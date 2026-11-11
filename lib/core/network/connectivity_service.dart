import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'api_health_service.dart';
import 'connectivity_state.dart';

class ConnectivityService {
  final Connectivity _connectivity;
  final ApiHealthService _apiHealthService;

  final StreamController<ApiAvailability> _statusController =
      StreamController<ApiAvailability>.broadcast();

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _periodicCheckTimer;
  ApiAvailability _currentStatus = ApiAvailability.offline;

  ConnectivityService({
    Connectivity? connectivity,
    ApiHealthService? apiHealthService,
  })  : _connectivity = connectivity ?? Connectivity(),
        _apiHealthService = apiHealthService ?? ApiHealthService() {
    _init();
  }

  ApiAvailability get currentStatus => _currentStatus;
  Stream<ApiAvailability> get onStatusChanged => _statusController.stream;

  void _init() {
    // Escucha cambios de conectividad física
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      _evaluateConnectivity(results);
    });

    // Comprobación periódica cada 30 segundos (OF-20)
    _periodicCheckTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      checkCurrentAvailability();
    });

    // Primera evaluación inmediata
    checkCurrentAvailability();
  }

  Future<ApiAvailability> checkCurrentAvailability() async {
    final results = await _connectivity.checkConnectivity();
    return _evaluateConnectivity(results);
  }

  Future<ApiAvailability> _evaluateConnectivity(List<ConnectivityResult> results) async {
    final hasNetwork = results.any((r) => r != ConnectivityResult.none);

    ApiAvailability newStatus;
    if (!hasNetwork) {
      newStatus = ApiAvailability.offline;
    } else {
      // Hay conexión física; comprobamos si la API de GraphQL responde efectivamente
      final isApiHealthy = await _apiHealthService.checkApiHealth();
      if (isApiHealthy) {
        newStatus = ApiAvailability.online;
      } else {
        newStatus = ApiAvailability.serviceUnavailable;
      }
    }

    if (_currentStatus != newStatus) {
      _currentStatus = newStatus;
      _statusController.add(newStatus);
    }

    return newStatus;
  }

  void dispose() {
    _subscription?.cancel();
    _periodicCheckTimer?.cancel();
    _statusController.close();
  }
}
