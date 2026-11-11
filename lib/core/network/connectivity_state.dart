enum ApiAvailability {
  online,
  offline,
  serviceUnavailable,
}

enum SyncStatus {
  idle,
  syncing,
  error,
}

enum DataSourceOrigin {
  local,
  remote,
}

/// Estado inmutable del indicador global de conectividad (IND-01 a IND-05)
class ConnectivityIndicatorState {
  final ApiAvailability availability;
  final SyncStatus syncStatus;
  final DataSourceOrigin dataOrigin;
  final DateTime? lastSyncTime;
  final String? errorMessage;

  const ConnectivityIndicatorState({
    required this.availability,
    this.syncStatus = SyncStatus.idle,
    this.dataOrigin = DataSourceOrigin.local,
    this.lastSyncTime,
    this.errorMessage,
  });

  /// Determina el estado prioritario para la UI sin contradicciones
  bool get isSyncing => syncStatus == SyncStatus.syncing;
  bool get isOnline => availability == ApiAvailability.online;
  bool get isOffline => availability == ApiAvailability.offline;
  bool get isServiceUnavailable => availability == ApiAvailability.serviceUnavailable;

  ConnectivityIndicatorState copyWith({
    ApiAvailability? availability,
    SyncStatus? syncStatus,
    DataSourceOrigin? dataOrigin,
    DateTime? lastSyncTime,
    String? errorMessage,
  }) {
    return ConnectivityIndicatorState(
      availability: availability ?? this.availability,
      syncStatus: syncStatus ?? this.syncStatus,
      dataOrigin: dataOrigin ?? this.dataOrigin,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectivityIndicatorState &&
          runtimeType == other.runtimeType &&
          availability == other.availability &&
          syncStatus == other.syncStatus &&
          dataOrigin == other.dataOrigin &&
          lastSyncTime == other.lastSyncTime;

  @override
  int get hashCode =>
      availability.hashCode ^
      syncStatus.hashCode ^
      dataOrigin.hashCode ^
      (lastSyncTime?.hashCode ?? 0);
}
