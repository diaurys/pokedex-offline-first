import 'package:drift/drift.dart';
import '../app_database.dart';
import '../../../features/pokemon/domain/entities/pokemon_entity.dart';

class FavoritesDao {
  final AppDatabase db;

  FavoritesDao(this.db);

  /// Comprueba reactivamente si un Pokémon es favorito
  Stream<bool> watchIsFavorite(int pokemonId) {
    return (db.select(db.favorites)..where((f) => f.pokemonId.equals(pokemonId)))
        .watchSingleOrNull()
        .map((f) => f != null);
  }

  /// Alterna favorito en menos de 150ms (RF-FAV-03)
  Future<bool> toggleFavorite(int pokemonId) async {
    final existing = await (db.select(db.favorites)
          ..where((f) => f.pokemonId.equals(pokemonId)))
        .getSingleOrNull();

    if (existing != null) {
      await (db.delete(db.favorites)..where((f) => f.pokemonId.equals(pokemonId))).go();
      return false;
    } else {
      await db.into(db.favorites).insert(
            FavoritesCompanion(
              pokemonId: Value(pokemonId),
              addedAt: Value(DateTime.now()),
            ),
          );
      return true;
    }
  }

  /// Observa la lista de favoritos como entidades del catálogo (RF-FAV-02, OF-07)
  Stream<List<PokemonListItem>> watchFavorites() {
    final query = db.select(db.favorites).join([
      innerJoin(db.pokemons, db.pokemons.id.equalsExp(db.favorites.pokemonId)),
    ]);

    return query.watch().asyncMap((rows) async {
      final List<PokemonListItem> items = [];

      for (final row in rows) {
        final p = row.readTable(db.pokemons);

        final types = await (db.select(db.pokemonTypes)
              ..where((t) => t.pokemonId.equals(p.id))
              ..orderBy([(t) => OrderingTerm(expression: t.slot)]))
            .get();

        items.add(
          PokemonListItem(
            id: p.id,
            name: p.name,
            height: p.height,
            weight: p.weight,
            generationId: p.generationId,
            types: types.map((t) => t.typeName).toList(),
            isFavorite: true,
            baseExperience: p.baseExperience,
          ),
        );
      }

      return items;
    });
  }

  Future<int> getFavoritesCount() async {
    final count = await db.favorites.count().getSingle();
    return count;
  }
}
