import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers.dart';
import '../../domain/entities/pokemon_entity.dart';

/// StreamProvider que conecta la base de datos local SQLite con la interfaz de usuario.
/// (Entregable 4: OF-16, OF-17, OF-18).
///
/// Principio Offline-First:
/// La interfaz NUNCA consume la API GraphQL directamente.
/// En su lugar, observa (watch) reactivamente la base de datos local SQLite.
/// Cuando SyncCoordinator inserta nuevos datos en SQLite, este Stream emite
/// automáticamente la lista actualizada sin necesidad de recargar la pantalla.
final pokemonCatalogStreamProvider = StreamProvider<List<PokemonListItem>>((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.watchCatalog();
});
