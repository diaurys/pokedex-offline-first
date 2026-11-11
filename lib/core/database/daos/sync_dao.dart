import 'package:drift/drift.dart';
import '../app_database.dart';

class SyncDao {
  final AppDatabase db;

  SyncDao(this.db);

  /// Registra una sincronización exitosa (PS-09, IND-04)
  Future<void> recordSync(String key, int totalRecords) async {
    await db.into(db.syncMetadata).insertOnConflictUpdate(
          SyncMetadataCompanion(
            key: Value(key),
            lastSyncTime: Value(DateTime.now()),
            totalRecords: Value(totalRecords),
          ),
        );
  }

  /// Observa la última fecha de sincronización
  Stream<DateTime?> watchLastSyncTime(String key) {
    return (db.select(db.syncMetadata)..where((s) => s.key.equals(key)))
        .watchSingleOrNull()
        .map((meta) => meta?.lastSyncTime);
  }

  Future<DateTime?> getLastSyncTime(String key) async {
    final meta = await (db.select(db.syncMetadata)..where((s) => s.key.equals(key)))
        .getSingleOrNull();
    return meta?.lastSyncTime;
  }
}
