import 'dart:async';
import 'dart:math';
import '../constants/api_constants.dart';
import '../database/daos/pokemon_dao.dart';
import '../database/daos/sync_dao.dart';
import '../network/connectivity_state.dart';
import '../../features/pokemon/data/datasources/pokemon_remote_data_source.dart';

class SyncCoordinator {
  final PokemonRemoteDataSource remoteDataSource;
  final PokemonDao pokemonDao;
  final SyncDao syncDao;

  final StreamController<SyncStatus> _syncStatusController =
      StreamController<SyncStatus>.broadcast();

  bool _isSyncing = false;
  SyncStatus _currentStatus = SyncStatus.idle;

  SyncCoordinator({
    required this.remoteDataSource,
    required this.pokemonDao,
    required this.syncDao,
  });

  bool get isSyncing => _isSyncing;
  SyncStatus get currentStatus => _currentStatus;
  Stream<SyncStatus> get onSyncStatusChanged => _syncStatusController.stream;

  void _updateStatus(SyncStatus status) {
    _currentStatus = status;
    _isSyncing = status == SyncStatus.syncing;
    _syncStatusController.add(status);
  }

  /// Sincroniza el catálogo de Pokémon en segundo plano (OF-01, OF-02, OF-12, OF-14)
  /// Sin bloquear la UI y previniendo ejecuciones duplicadas concurrentes (RNF-RES-03)
  Future<bool> syncCatalog({int limit = 24, int offset = 0, bool force = false}) async {
    if (_isSyncing && !force) {
      return false; // Evita sincronizaciones concurrentes duplicadas
    }

    _updateStatus(SyncStatus.syncing);

    int attempt = 0;
    while (attempt < ApiConstants.maxRetryAttempts) {
      attempt++;
      try {
        final remoteItems = await remoteDataSource.fetchCatalog(limit: limit, offset: offset);

        // Guardar en transacción en la base de datos local (OF-02, OF-13)
        await pokemonDao.upsertCatalogBatch(remoteItems);

        // Registrar timestamp de última sincronización (PS-09, IND-04)
        final totalStored = await pokemonDao.getStoredCount();
        await syncDao.recordSync('catalog_sync', totalStored);

        _updateStatus(SyncStatus.idle);
        return true;
      } catch (e) {
        if (attempt >= ApiConstants.maxRetryAttempts) {
          _updateStatus(SyncStatus.error);
          return false;
        }

        // Backoff exponencial: 2s, 4s, 8s (RNF-RES-02)
        final delaySeconds = ApiConstants.initialRetryDelay.inSeconds * pow(2, attempt - 1);
        await Future.delayed(Duration(seconds: delaySeconds.toInt()));
      }
    }

    _updateStatus(SyncStatus.error);
    return false;
  }

  /// Sincroniza y actualiza los detalles completos de un Pokémon específico
  Future<bool> syncPokemonDetail(int id) async {
    try {
      final detailData = await remoteDataSource.fetchPokemonDetail(id);

      await pokemonDao.upsertPokemonDetailFull(
        id: detailData['id'] as int,
        name: detailData['name'] as String,
        height: detailData['height'] as int,
        weight: detailData['weight'] as int,
        baseExp: detailData['base_experience'] as int?,
        generationId: detailData['generation_id'] as int,
        flavorText: detailData['flavor_text'] as String?,
        speciesGenus: detailData['species_genus'] as String?,
        evolutionChainId: detailData['evolution_chain_id'] as int?,
        types: (detailData['types'] as List).cast<Map<String, dynamic>>(),
        stats: (detailData['stats'] as List).cast<Map<String, dynamic>>(),
        abilities: (detailData['abilities'] as List).cast<Map<String, dynamic>>(),
        moves: (detailData['moves'] as List).cast<Map<String, dynamic>>(),
        evolutions: (detailData['evolutions'] as List).cast<Map<String, dynamic>>(),
      );

      return true;
    } catch (_) {
      return false;
    }
  }

  /// Comprobación obligatoria y restauración de datos alterados localmente (OF-19, OF-20, PA-16)
  /// Se ejecuta al abrir un detalle, al iniciar, al reconectar o periódicamente.
  Future<bool> checkAndRestoreIfTampered(int pokemonId) async {
    try {
      final localDetail = await pokemonDao.getPokemonDetail(pokemonId);
      if (localDetail != null && localDetail.isTampered) {
        // Detectada diferencia con el hash original -> Restaurar desde PokéAPI
        final restored = await syncPokemonDetail(pokemonId);
        return restored;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  void dispose() {
    _syncStatusController.close();
  }
}
