import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database/app_database.dart';
import 'database/daos/pokemon_dao.dart';
import 'database/daos/favorites_dao.dart';
import 'database/daos/trivia_dao.dart';
import 'database/daos/sync_dao.dart';
import 'network/api_health_service.dart';
import 'network/connectivity_service.dart';
import 'network/connectivity_state.dart';
import 'sync/sync_coordinator.dart';
import '../features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import '../features/pokemon/domain/repositories/pokemon_repository.dart';
import '../features/pokemon/data/repositories/pokemon_repository_impl.dart';
import '../features/favorites/domain/repositories/favorites_repository.dart';
import '../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../features/trivia/domain/repositories/trivia_repository.dart';
import '../features/trivia/data/repositories/trivia_repository_impl.dart';

// --- Base de Datos & DAOs ---
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final pokemonDaoProvider = Provider<PokemonDao>((ref) {
  return PokemonDao(ref.watch(appDatabaseProvider));
});

final favoritesDaoProvider = Provider<FavoritesDao>((ref) {
  return FavoritesDao(ref.watch(appDatabaseProvider));
});

final triviaDaoProvider = Provider<TriviaDao>((ref) {
  return TriviaDao(ref.watch(appDatabaseProvider));
});

final syncDaoProvider = Provider<SyncDao>((ref) {
  return SyncDao(ref.watch(appDatabaseProvider));
});

// --- Servicios de Red y GraphQL ---
final apiHealthServiceProvider = Provider<ApiHealthService>((ref) {
  return ApiHealthService();
});

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService(
    apiHealthService: ref.watch(apiHealthServiceProvider),
  );
  ref.onDispose(() => service.dispose());
  return service;
});

final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((ref) {
  return PokemonRemoteDataSourceImpl();
});

// --- Coordinador de Sincronización (Offline-First Engine) ---
final syncCoordinatorProvider = Provider<SyncCoordinator>((ref) {
  final coordinator = SyncCoordinator(
    remoteDataSource: ref.watch(pokemonRemoteDataSourceProvider),
    pokemonDao: ref.watch(pokemonDaoProvider),
    syncDao: ref.watch(syncDaoProvider),
  );
  ref.onDispose(() => coordinator.dispose());
  return coordinator;
});

// --- Repositorios (Clean Architecture) ---
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(
    pokemonDao: ref.watch(pokemonDaoProvider),
    syncCoordinator: ref.watch(syncCoordinatorProvider),
  );
});

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepositoryImpl(ref.watch(favoritesDaoProvider));
});

final triviaRepositoryProvider = Provider<TriviaRepository>((ref) {
  return TriviaRepositoryImpl(ref.watch(triviaDaoProvider));
});

// --- Indicador Global de Conectividad (IND-01 a IND-05) ---
final connectivityIndicatorProvider =
    StreamNotifierProvider<ConnectivityIndicatorNotifier, ConnectivityIndicatorState>(() {
  return ConnectivityIndicatorNotifier();
});

class ConnectivityIndicatorNotifier extends StreamNotifier<ConnectivityIndicatorState> {
  @override
  Stream<ConnectivityIndicatorState> build() async* {
    final connectivityService = ref.watch(connectivityServiceProvider);
    final syncCoordinator = ref.watch(syncCoordinatorProvider);
    final syncDao = ref.watch(syncDaoProvider);

    // Estado inicial
    final lastSync = await syncDao.getLastSyncTime('catalog_sync');
    var currentState = ConnectivityIndicatorState(
      availability: connectivityService.currentStatus,
      syncStatus: syncCoordinator.currentStatus,
      dataOrigin: DataSourceOrigin.local,
      lastSyncTime: lastSync,
    );

    yield currentState;

    // Escucha de disponibilidad de API
    connectivityService.onStatusChanged.listen((avail) async {
      final syncTime = await syncDao.getLastSyncTime('catalog_sync');
      currentState = currentState.copyWith(
        availability: avail,
        lastSyncTime: syncTime,
      );
      state = AsyncData(currentState);

      // Si se recupera la conexión, sincronizar automáticamente (OF-11, OF-12)
      if (avail == ApiAvailability.online) {
        syncCoordinator.syncCatalog();
      }
    });

    // Escucha de estado de sincronización
    syncCoordinator.onSyncStatusChanged.listen((syncStatus) async {
      final syncTime = await syncDao.getLastSyncTime('catalog_sync');
      currentState = currentState.copyWith(
        syncStatus: syncStatus,
        lastSyncTime: syncTime,
      );
      state = AsyncData(currentState);
    });
  }

  void refreshAvailability() {
    ref.read(connectivityServiceProvider).checkCurrentAvailability();
  }
}
