/// Excepciones de infraestructura (Capa Data)
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class ServerException extends AppException {
  const ServerException([super.message = 'Error en el servidor de PokeAPI', super.statusCode]);
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'Sin conexión a Internet']);
}

class ApiUnavailableException extends AppException {
  const ApiUnavailableException([super.message = 'Hay red pero el servicio GraphQL no responde']);
}

class RequestTimeoutException extends AppException {
  const RequestTimeoutException([super.message = 'Tiempo de espera agotado al conectar con PokeAPI']);
}

class RateLimitException extends AppException {
  const RateLimitException([super.message = 'Límite de peticiones alcanzado en PokeAPI']);
}

class DatabaseException extends AppException {
  const DatabaseException([super.message = 'Error en la base de datos local']);
}

class DataTamperedException extends AppException {
  final int pokemonId;
  const DataTamperedException(this.pokemonId, [super.message = 'Datos locales alterados detectados']);
}
