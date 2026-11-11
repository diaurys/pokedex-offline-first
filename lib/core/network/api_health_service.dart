import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';

class ApiHealthService {
  final http.Client _client;

  ApiHealthService({http.Client? client}) : _client = client ?? http.Client();

  /// Comprueba la disponibilidad REAL del servicio GraphQL (OF-11, IND-03, PA-08)
  Future<bool> checkApiHealth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // PA-08: Mecanismo de simulación de caída de API con red activa
      final simulateDown = prefs.getBool(ApiConstants.prefSimulateApiDown) ?? false;
      if (simulateDown) {
        return false;
      }

      final endpoint = prefs.getString(ApiConstants.prefCustomGraphQLEndpoint) ??
          ApiConstants.defaultGraphQLEndpoint;

      // Petición GraphQL ultra ligera para comprobación de salud (< 5s)
      final response = await _client
          .post(
            Uri.parse(endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'query': '{ pokemon(limit: 1) { id } }',
            }),
          )
          .timeout(ApiConstants.healthCheckTimeout);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body is Map && body.containsKey('data')) {
          return true;
        }
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
