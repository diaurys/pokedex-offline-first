import '../../domain/repositories/favorites_repository.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../../../core/database/daos/favorites_dao.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDao _favoritesDao;

  FavoritesRepositoryImpl(this._favoritesDao);

  @override
  Stream<bool> watchIsFavorite(int pokemonId) {
    return _favoritesDao.watchIsFavorite(pokemonId);
  }

  @override
  Future<bool> toggleFavorite(int pokemonId) {
    return _favoritesDao.toggleFavorite(pokemonId);
  }

  @override
  Stream<List<PokemonListItem>> watchFavorites() {
    return _favoritesDao.watchFavorites();
  }

  @override
  Future<int> getFavoritesCount() {
    return _favoritesDao.getFavoritesCount();
  }
}
