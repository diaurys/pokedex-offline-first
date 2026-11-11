import 'package:drift/drift.dart';

class Favorites extends Table {
  IntColumn get pokemonId => integer()();
  DateTimeColumn get addedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {pokemonId};
}

class TriviaRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get score => integer()();
  IntColumn get correctAnswers => integer()();
  IntColumn get totalQuestions => integer()();
  DateTimeColumn get playedAt => dateTime().withDefault(currentDateAndTime)();
}

class SyncMetadata extends Table {
  TextColumn get key => text()();
  DateTimeColumn get lastSyncTime => dateTime()();
  IntColumn get totalRecords => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {key};
}
