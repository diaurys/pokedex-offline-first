/// Fallos de dominio (Capa Domain)
/// Totalmente agnósticos a Flutter, GraphQL y SQLite
abstract class Failure {
  final String message;
  final String? code;

  const Failure(this.message, [this.code]);

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code;

  @override
  int get hashCode => message.hashCode ^ (code?.hashCode ?? 0);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Error en el servidor de PokeAPI', super.code = 'SERVER_ERROR']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sin conexión a Internet', super.code = 'NO_INTERNET']);
}

class ApiUnavailableFailure extends Failure {
  const ApiUnavailableFailure([super.message = 'Servicio no disponible temporalmente', super.code = 'API_DOWN']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Tiempo de espera agotado', super.code = 'TIMEOUT']);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'Error al acceder a la base de datos local', super.code = 'DATABASE_ERROR']);
}

class DataTamperedFailure extends Failure {
  final int entityId;
  const DataTamperedFailure(this.entityId, [super.message = 'Datos locales inconsistentes detectados', super.code = 'DATA_TAMPERED']);
}
