import 'package:drift/drift.dart';
import '../../utils/hash_helper.dart';
import '../app_database.dart';
import '../../../features/pokemon/domain/entities/pokemon_entity.dart';

class PokemonDao {
  final AppDatabase db;

  PokemonDao(this.db);

  /// Observa el catálogo con filtros, búsqueda y ordenación desde SQLite (OF-02, OF-06, RF-CAT)
  Stream<List<PokemonListItem>> watchCatalog({
    String? search,
    String? typeFilter,
    int? generationFilter,
    String sortBy = 'id', // 'id', 'name', 'stats'
    bool ascending = true,
  }) {
    // Consulta base sobre pokemons
    final query = db.select(db.pokemons);

    // Filtro por generación
    if (generationFilter != null && generationFilter > 0) {
      query.where((tbl) => tbl.generationId.equals(generationFilter));
    }

    // Filtro por búsqueda (nombre o número)
    if (search != null && search.trim().isNotEmpty) {
      final cleanSearch = search.trim().toLowerCase();
      final numericSearch = int.tryParse(cleanSearch);
      if (numericSearch != null) {
        query.where((tbl) => tbl.id.equals(numericSearch));
      } else {
        query.where((tbl) => tbl.name.like('%$cleanSearch%'));
      }
    }

    // Ordenación
    if (sortBy == 'name') {
      query.orderBy([
        (tbl) => OrderingTerm(
              expression: tbl.name,
              mode: ascending ? OrderingMode.asc : OrderingMode.desc,
            )
      ]);
    } else {
      query.orderBy([
        (tbl) => OrderingTerm(
              expression: tbl.id,
              mode: ascending ? OrderingMode.asc : OrderingMode.desc,
            )
      ]);
    }

    // Observamos los cambios en la base de datos local
    return query.watch().asyncMap((pokemonRows) async {
      final List<PokemonListItem> items = [];

      for (final p in pokemonRows) {
        // Obtenemos los tipos del Pokémon
        final typesQuery = await (db.select(db.pokemonTypes)
              ..where((t) => t.pokemonId.equals(p.id))
              ..orderBy([(t) => OrderingTerm(expression: t.slot)]))
            .get();
        final typeNames = typesQuery.map((t) => t.typeName).toList();

        // Si hay filtro por tipo, verificamos que lo contenga
        if (typeFilter != null &&
            typeFilter.isNotEmpty &&
            typeFilter != 'all' &&
            !typeNames.contains(typeFilter.toLowerCase())) {
          continue;
        }

        // Verificamos si es favorito
        final favCheck = await (db.select(db.favorites)
              ..where((f) => f.pokemonId.equals(p.id)))
            .getSingleOrNull();

        // Estadísticas base para ordenamiento por total base stats
        final stats = await (db.select(db.pokemonStats)
              ..where((s) => s.pokemonId.equals(p.id)))
            .get();
        final totalStats = stats.fold<int>(0, (sum, s) => sum + s.baseStat);

        items.add(
          PokemonListItem(
            id: p.id,
            name: p.name,
            height: p.height,
            weight: p.weight,
            generationId: p.generationId,
            types: typeNames,
            isFavorite: favCheck != null,
            baseExperience: p.baseExperience,
            totalBaseStats: totalStats,
          ),
        );
      }

      // Si el orden pedido es por total base stats
      if (sortBy == 'stats') {
        items.sort((a, b) => ascending
            ? a.totalBaseStats.compareTo(b.totalBaseStats)
            : b.totalBaseStats.compareTo(a.totalBaseStats));
      }

      return items;
    });
  }

  /// Observa un Pokémon en detalle para la pantalla de detalle (OF-02, RF-DET)
  Stream<PokemonDetail?> watchPokemonDetail(int id) {
    return (db.select(db.pokemons)..where((tbl) => tbl.id.equals(id)))
        .watchSingleOrNull()
        .asyncMap((pokemonRow) async {
      if (pokemonRow == null) return null;
      return _buildPokemonDetail(pokemonRow);
    });
  }

  Future<PokemonDetail?> getPokemonDetail(int id) async {
    final row = await (db.select(db.pokemons)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return _buildPokemonDetail(row);
  }

  Future<PokemonDetail> _buildPokemonDetail(Pokemon p) async {
    // Tipos
    final typeRows = await (db.select(db.pokemonTypes)
          ..where((t) => t.pokemonId.equals(p.id))
          ..orderBy([(t) => OrderingTerm(expression: t.slot)]))
        .get();
    final types = typeRows
        .map((t) => PokemonTypeEntity(id: t.typeId, name: t.typeName, slot: t.slot))
        .toList();

    // Stats
    final statRows = await (db.select(db.pokemonStats)
          ..where((s) => s.pokemonId.equals(p.id)))
        .get();
    final stats = statRows
        .map((s) => PokemonStatEntity(name: s.statName, value: s.baseStat))
        .toList();

    // Habilidades
    final abilityRows = await (db.select(db.pokemonAbilities)
          ..where((a) => a.pokemonId.equals(p.id)))
        .get();
    final abilities = abilityRows
        .map((a) => PokemonAbilityEntity(
              name: a.abilityName,
              isHidden: a.isHidden,
              shortEffect: a.shortEffect,
            ))
        .toList();

    // Movimientos
    final moveRows = await (db.select(db.pokemonMoves)
          ..where((m) => m.pokemonId.equals(p.id)))
        .get();
    final moves = moveRows
        .map((m) => PokemonMoveEntity(
              id: m.moveId,
              name: m.moveName,
              typeName: m.typeName,
              power: m.power,
              accuracy: m.accuracy,
              pp: m.pp,
              level: m.level,
              learnMethod: m.learnMethod,
            ))
        .toList();

    // Evoluciones
    List<PokemonEvolutionEntity> evolutions = [];
    if (p.evolutionChainId != null) {
      final evoRows = await (db.select(db.pokemonEvolutions)
            ..where((e) => e.chainId.equals(p.evolutionChainId!))
            ..orderBy([(e) => OrderingTerm(expression: e.speciesId)]))
          .get();
      evolutions = evoRows
          .map((e) => PokemonEvolutionEntity(
                speciesId: e.speciesId,
                speciesName: e.speciesName,
                evolvesFromId: e.evolvesFromId,
                triggerName: e.triggerName,
                minLevel: e.minLevel,
              ))
          .toList();
    }

    // Favorito
    final fav = await (db.select(db.favorites)..where((f) => f.pokemonId.equals(p.id)))
        .getSingleOrNull();

    // Comprobación de alteración local (OF-19, PA-16)
    final isTampered = checkIsTampered(
      id: p.id,
      name: p.name,
      height: p.height,
      weight: p.weight,
      types: types.map((t) => t.name).toList(),
      storedHash: p.contentHash,
    );

    return PokemonDetail(
      id: p.id,
      name: p.name,
      height: p.height,
      weight: p.weight,
      baseExperience: p.baseExperience,
      generationId: p.generationId,
      flavorText: p.flavorText,
      speciesGenus: p.speciesGenus,
      evolutionChainId: p.evolutionChainId,
      types: types,
      stats: stats,
      abilities: abilities,
      moves: moves,
      evolutions: evolutions,
      isFavorite: fav != null,
      isTampered: isTampered,
    );
  }

  /// Verifica si los datos locales fueron manipulados en SQLite (OF-19, PA-16)
  bool checkIsTampered({
    required int id,
    required String name,
    required int height,
    required int weight,
    required List<String> types,
    required String? storedHash,
  }) {
    if (storedHash == null) return false;
    final currentHash = HashHelper.calculatePokemonHash(
      id: id,
      name: name,
      height: height,
      weight: weight,
      types: types,
    );
    return currentHash != storedHash;
  }

  /// Upsert transaccional de un lote de Pokémon del catálogo (OF-02, OF-13, PA-13)
  Future<void> upsertCatalogBatch(List<Map<String, dynamic>> pokemonDataList) async {
    await db.transaction(() async {
      for (final item in pokemonDataList) {
        final id = item['id'] as int;
        final name = item['name'] as String;
        final height = item['height'] as int;
        final weight = item['weight'] as int;
        final baseExp = item['base_experience'] as int?;
        final genId = item['generation_id'] as int? ?? 1;
        final types = (item['types'] as List).cast<Map<String, dynamic>>();

        final typeNames = types.map((t) => t['name'] as String).toList();
        final contentHash = HashHelper.calculatePokemonHash(
          id: id,
          name: name,
          height: height,
          weight: weight,
          types: typeNames,
        );

        // Inserción o actualización en pokemons
        await db.into(db.pokemons).insertOnConflictUpdate(
              PokemonsCompanion(
                id: Value(id),
                name: Value(name),
                height: Value(height),
                weight: Value(weight),
                baseExperience: Value(baseExp),
                generationId: Value(genId),
                contentHash: Value(contentHash),
                updatedAt: Value(DateTime.now()),
              ),
            );

        // Reemplazo transaccional de tipos
        await (db.delete(db.pokemonTypes)..where((t) => t.pokemonId.equals(id))).go();
        for (final t in types) {
          await db.into(db.pokemonTypes).insert(
                PokemonTypesCompanion(
                  pokemonId: Value(id),
                  slot: Value(t['slot'] as int),
                  typeName: Value(t['name'] as String),
                  typeId: Value(t['id'] as int),
                ),
              );
        }
      }
    });
  }

  /// Upsert transaccional de los detalles completos de un Pokémon (OF-02, RF-DET)
  Future<void> upsertPokemonDetailFull({
    required int id,
    required String name,
    required int height,
    required int weight,
    int? baseExp,
    required int generationId,
    String? flavorText,
    String? speciesGenus,
    int? evolutionChainId,
    required List<Map<String, dynamic>> types,
    required List<Map<String, dynamic>> stats,
    required List<Map<String, dynamic>> abilities,
    required List<Map<String, dynamic>> moves,
    required List<Map<String, dynamic>> evolutions,
  }) async {
    await db.transaction(() async {
      final typeNames = types.map((t) => t['name'] as String).toList();
      final contentHash = HashHelper.calculatePokemonHash(
        id: id,
        name: name,
        height: height,
        weight: weight,
        types: typeNames,
      );

      // Actualizar registro principal en pokemons
      await db.into(db.pokemons).insertOnConflictUpdate(
            PokemonsCompanion(
              id: Value(id),
              name: Value(name),
              height: Value(height),
              weight: Value(weight),
              baseExperience: Value(baseExp),
              generationId: Value(generationId),
              flavorText: Value(flavorText),
              speciesGenus: Value(speciesGenus),
              evolutionChainId: Value(evolutionChainId),
              contentHash: Value(contentHash),
              updatedAt: Value(DateTime.now()),
            ),
          );

      // Tipos
      await (db.delete(db.pokemonTypes)..where((t) => t.pokemonId.equals(id))).go();
      for (final t in types) {
        await db.into(db.pokemonTypes).insert(
              PokemonTypesCompanion(
                pokemonId: Value(id),
                slot: Value(t['slot'] as int),
                typeName: Value(t['name'] as String),
                typeId: Value(t['id'] as int),
              ),
            );
      }

      // Stats
      await (db.delete(db.pokemonStats)..where((s) => s.pokemonId.equals(id))).go();
      for (final s in stats) {
        await db.into(db.pokemonStats).insert(
              PokemonStatsCompanion(
                pokemonId: Value(id),
                statName: Value(s['name'] as String),
                baseStat: Value(s['value'] as int),
              ),
            );
      }

      // Habilidades
      await (db.delete(db.pokemonAbilities)..where((a) => a.pokemonId.equals(id))).go();
      for (final a in abilities) {
        await db.into(db.pokemonAbilities).insert(
              PokemonAbilitiesCompanion(
                pokemonId: Value(id),
                abilityName: Value(a['name'] as String),
                isHidden: Value(a['is_hidden'] as bool),
                shortEffect: Value(a['short_effect'] as String?),
              ),
            );
      }

      // Movimientos
      await (db.delete(db.pokemonMoves)..where((m) => m.pokemonId.equals(id))).go();
      for (final m in moves) {
        await db.into(db.pokemonMoves).insert(
              PokemonMovesCompanion(
                pokemonId: Value(id),
                moveId: Value(m['id'] as int),
                moveName: Value(m['name'] as String),
                typeName: Value(m['type_name'] as String),
                power: Value(m['power'] as int?),
                accuracy: Value(m['accuracy'] as int?),
                pp: Value(m['pp'] as int?),
                level: Value(m['level'] as int? ?? 0),
                learnMethod: Value(m['learn_method'] as String? ?? 'level-up'),
              ),
            );
      }

      // Evoluciones
      if (evolutionChainId != null && evolutions.isNotEmpty) {
        await (db.delete(db.pokemonEvolutions)
              ..where((e) => e.chainId.equals(evolutionChainId)))
            .go();
        for (final e in evolutions) {
          await db.into(db.pokemonEvolutions).insert(
                PokemonEvolutionsCompanion(
                  chainId: Value(evolutionChainId),
                  speciesId: Value(e['species_id'] as int),
                  speciesName: Value(e['species_name'] as String),
                  evolvesFromId: Value(e['evolves_from_id'] as int?),
                  triggerName: Value(e['trigger_name'] as String?),
                  minLevel: Value(e['min_level'] as int?),
                ),
              );
        }
      }
    });
  }

  /// Cantidad de Pokémon descargados en la base local (OF-09, PA-11)
  Future<int> getStoredCount() async {
    final count = await db.pokemons.count().getSingle();
    return count;
  }

  /// Obtiene Pokémon almacenados para la trivia offline (OF-09, RF-TRV)
  Future<List<PokemonListItem>> getPokemonsForTrivia({int limit = 20}) async {
    final query = db.select(db.pokemons)..limit(limit);
    final rows = await query.get();

    final List<PokemonListItem> result = [];
    for (final r in rows) {
      final types = await (db.select(db.pokemonTypes)
            ..where((t) => t.pokemonId.equals(r.id)))
          .get();
      result.add(
        PokemonListItem(
          id: r.id,
          name: r.name,
          height: r.height,
          weight: r.weight,
          generationId: r.generationId,
          types: types.map((t) => t.typeName).toList(),
        ),
      );
    }
    return result;
  }

  /// Método para el Inspector de BD / Simulación de alteración (PA-16)
  Future<void> simulateTamperPokemon(int id, String tamperedName) async {
    await (db.update(db.pokemons)..where((tbl) => tbl.id.equals(id))).write(
      PokemonsCompanion(name: Value(tamperedName)),
    );
  }
}
