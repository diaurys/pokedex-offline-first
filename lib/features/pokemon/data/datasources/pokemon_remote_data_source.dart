import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';

abstract class PokemonRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchCatalog({int limit = 24, int offset = 0});
  Future<Map<String, dynamic>> fetchPokemonDetail(int id);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client _client;

  PokemonRemoteDataSourceImpl({http.Client? client}) : _client = client ?? http.Client();

  Future<String> _getEndpoint() async {
    final prefs = await SharedPreferences.getInstance();
    
    // PA-08: Simulación de caída de API
    final simulateDown = prefs.getBool(ApiConstants.prefSimulateApiDown) ?? false;
    if (simulateDown) {
      throw const ApiUnavailableException('Simulación activa: PokeAPI GraphQL inaccesible (PA-08)');
    }

    return prefs.getString(ApiConstants.prefCustomGraphQLEndpoint) ??
        ApiConstants.defaultGraphQLEndpoint;
  }

  @override
  Future<List<Map<String, dynamic>>> fetchCatalog({int limit = 24, int offset = 0}) async {
    final endpoint = await _getEndpoint();

    const query = '''
    query getCatalog(\$limit: Int!, \$offset: Int!) {
      pokemon(limit: \$limit, offset: \$offset, order_by: {id: asc}) {
        id
        name
        height
        weight
        base_experience
        pokemontypes(order_by: {slot: asc}) {
          slot
          type {
            id
            name
          }
        }
        pokemonspecy {
          generation_id
        }
      }
    }
    ''';

    try {
      final response = await _client
          .post(
            Uri.parse(endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'query': query,
              'variables': {'limit': limit, 'offset': offset},
            }),
          )
          .timeout(ApiConstants.requestTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        if (body.containsKey('errors')) {
          throw ServerException('GraphQL Error: ${body['errors']}');
        }

        final data = body['data'];
        if (data == null || !data.containsKey('pokemon')) {
          throw const ServerException('Formato de respuesta inválido de PokeAPI');
        }

        final List rawList = data['pokemon'] as List;
        return rawList.map((item) {
          final typesList = (item['pokemontypes'] as List? ?? []).map((t) {
            final typeData = t['type'] as Map<String, dynamic>;
            return {
              'slot': t['slot'] as int? ?? 1,
              'name': typeData['name'] as String,
              'id': typeData['id'] as int? ?? 0,
            };
          }).toList();

          final genId = item['pokemonspecy']?['generation_id'] as int? ?? 1;

          return {
            'id': item['id'] as int,
            'name': item['name'] as String,
            'height': item['height'] as int,
            'weight': item['weight'] as int,
            'base_experience': item['base_experience'] as int?,
            'generation_id': genId,
            'types': typesList,
          };
        }).toList();
      } else if (response.statusCode == 429) {
        throw const RateLimitException();
      } else {
        throw ServerException('Error del servidor: HTTP ${response.statusCode}', response.statusCode);
      }
    } on TimeoutException {
      throw const RequestTimeoutException();
    } on AppException {
      rethrow;
    } catch (e) {
      throw ServerException('Error inesperado de conexión: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> fetchPokemonDetail(int id) async {
    final endpoint = await _getEndpoint();

    const query = '''
    query getPokemonDetail(\$id: Int!) {
      pokemon(where: {id: {_eq: \$id}}) {
        id
        name
        height
        weight
        base_experience
        pokemontypes(order_by: {slot: asc}) {
          slot
          type {
            id
            name
          }
        }
        pokemonstats(order_by: {stat_id: asc}) {
          base_stat
          stat {
            name
          }
        }
        pokemonabilities(order_by: {slot: asc}) {
          is_hidden
          ability {
            name
            abilityeffecttexts(where: {language_id: {_eq: 9}}, limit: 1) {
              short_effect
            }
          }
        }
        pokemonmoves(limit: 30) {
          move {
            id
            name
            power
            accuracy
            pp
            type {
              name
            }
          }
          move_learn_method_id
          level
        }
        pokemonspecy {
          id
          generation_id
          evolution_chain_id
          pokemonspeciesflavortexts(where: {language_id: {_eq: 9}}, limit: 1) {
            flavor_text
          }
          pokemonspeciesnames(where: {language_id: {_eq: 9}}, limit: 1) {
            genus
          }
          evolutionchain {
            pokemonspecies(order_by: {id: asc}) {
              id
              name
              evolves_from_species_id
            }
          }
        }
      }
    }
    ''';

    try {
      final response = await _client
          .post(
            Uri.parse(endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'query': query,
              'variables': {'id': id},
            }),
          )
          .timeout(ApiConstants.requestTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        if (body.containsKey('errors')) {
          throw ServerException('GraphQL Error: ${body['errors']}');
        }

        final data = body['data'];
        final List list = data?['pokemon'] as List? ?? [];
        if (list.isEmpty) {
          throw const ServerException('Pokémon no encontrado en PokeAPI');
        }

        final item = list.first as Map<String, dynamic>;

        // Parseo de tipos
        final types = (item['pokemontypes'] as List? ?? []).map((t) {
          final typeMap = t['type'] as Map<String, dynamic>;
          return {
            'slot': t['slot'] as int? ?? 1,
            'name': typeMap['name'] as String,
            'id': typeMap['id'] as int? ?? 0,
          };
        }).toList();

        // Parseo de stats
        final stats = (item['pokemonstats'] as List? ?? []).map((s) {
          final statMap = s['stat'] as Map<String, dynamic>;
          return {
            'name': statMap['name'] as String,
            'value': s['base_stat'] as int,
          };
        }).toList();

        // Parseo de habilidades
        final abilities = (item['pokemonabilities'] as List? ?? []).map((a) {
          final abilityMap = a['ability'] as Map<String, dynamic>;
          final effectTexts = abilityMap['abilityeffecttexts'] as List? ?? [];
          final shortEffect = effectTexts.isNotEmpty
              ? effectTexts.first['short_effect'] as String?
              : null;
          return {
            'name': abilityMap['name'] as String,
            'is_hidden': a['is_hidden'] as bool? ?? false,
            'short_effect': shortEffect,
          };
        }).toList();

        // Parseo de movimientos
        final moves = (item['pokemonmoves'] as List? ?? []).map((m) {
          final moveMap = m['move'] as Map<String, dynamic>;
          final typeMap = moveMap['type'] as Map<String, dynamic>? ?? {};
          return {
            'id': moveMap['id'] as int,
            'name': moveMap['name'] as String,
            'type_name': typeMap['name'] as String? ?? 'normal',
            'power': moveMap['power'] as int?,
            'accuracy': moveMap['accuracy'] as int?,
            'pp': moveMap['pp'] as int?,
            'level': m['level'] as int? ?? 0,
            'learn_method': 'level-up',
          };
        }).toList();

        // Parseo de especie y evolución
        final specy = item['pokemonspecy'] as Map<String, dynamic>?;
        final genId = specy?['generation_id'] as int? ?? 1;
        final evoChainId = specy?['evolution_chain_id'] as int?;

        final flavorTexts = specy?['pokemonspeciesflavortexts'] as List? ?? [];
        final rawFlavor = flavorTexts.isNotEmpty
            ? flavorTexts.first['flavor_text'] as String?
            : null;
        final cleanFlavor = rawFlavor?.replaceAll('\n', ' ').replaceAll('\f', ' ');

        final genera = specy?['pokemonspeciesnames'] as List? ?? [];
        final genus = genera.isNotEmpty ? genera.first['genus'] as String? : null;

        // Evoluciones
        final List<Map<String, dynamic>> evolutions = [];
        final evoSpecies = specy?['evolutionchain']?['pokemonspecies'] as List? ?? [];
        for (final sp in evoSpecies) {
          evolutions.add({
            'species_id': sp['id'] as int,
            'species_name': sp['name'] as String,
            'evolves_from_id': sp['evolves_from_species_id'] as int?,
            'trigger_name': 'level-up',
            'min_level': null,
          });
        }

        return {
          'id': item['id'] as int,
          'name': item['name'] as String,
          'height': item['height'] as int,
          'weight': item['weight'] as int,
          'base_experience': item['base_experience'] as int?,
          'generation_id': genId,
          'flavor_text': cleanFlavor,
          'species_genus': genus,
          'evolution_chain_id': evoChainId,
          'types': types,
          'stats': stats,
          'abilities': abilities,
          'moves': moves,
          'evolutions': evolutions,
        };
      } else {
        throw ServerException('Error del servidor: HTTP ${response.statusCode}');
      }
    } on TimeoutException {
      throw const RequestTimeoutException();
    } on AppException {
      rethrow;
    } catch (e) {
      throw ServerException('Error inesperado de conexión: $e');
    }
  }
}
