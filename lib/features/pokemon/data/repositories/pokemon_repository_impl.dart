import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../../../../core/database/daos/pokemon_dao.dart';
import '../../../../core/sync/sync_coordinator.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDao pokemonDao;
  final SyncCoordinator syncCoordinator;

  PokemonRepositoryImpl({
    required this.pokemonDao,
    required this.syncCoordinator,
  });

  @override
  Stream<List<PokemonListItem>> watchCatalog({
    String? search,
    String? typeFilter,
    int? generationFilter,
    String sortBy = 'id',
    bool ascending = true,
  }) {
    return pokemonDao.watchCatalog(
      search: search,
      typeFilter: typeFilter,
      generationFilter: generationFilter,
      sortBy: sortBy,
      ascending: ascending,
    );
  }

  @override
  Stream<PokemonDetail?> watchPokemonDetail(int id) {
    return pokemonDao.watchPokemonDetail(id);
  }

  @override
  Future<bool> syncCatalog({int limit = 24, int offset = 0, bool force = false}) {
    return syncCoordinator.syncCatalog(limit: limit, offset: offset, force: force);
  }

  @override
  Future<bool> syncPokemonDetail(int id) {
    return syncCoordinator.syncPokemonDetail(id);
  }

  @override
  Future<bool> checkAndRestoreIfTampered(int id) {
    return syncCoordinator.checkAndRestoreIfTampered(id);
  }

  @override
  Future<int> getStoredCount() {
    return pokemonDao.getStoredCount();
  }

  @override
  Future<List<PokemonListItem>> getPokemonsForTrivia({int limit = 20}) {
    return pokemonDao.getPokemonsForTrivia(limit: limit);
  }
}
