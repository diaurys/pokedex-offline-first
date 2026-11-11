import '../../../pokemon/domain/entities/pokemon_entity.dart';

abstract class FavoritesRepository {
  Stream<bool> watchIsFavorite(int pokemonId);
  Future<bool> toggleFavorite(int pokemonId);
  Stream<List<PokemonListItem>> watchFavorites();
  Future<int> getFavoritesCount();
}
