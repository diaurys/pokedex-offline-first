import 'package:drift/drift.dart';

class Pokemons extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get height => integer()();
  IntColumn get weight => integer()();
  IntColumn get baseExperience => integer().nullable()();
  IntColumn get generationId => integer().withDefault(const Constant(1))();
  TextColumn get flavorText => text().nullable()();
  TextColumn get speciesGenus => text().nullable()();
  IntColumn get evolutionChainId => integer().nullable()();
  
  // Hash para detección obligatoria de alteraciones locales (OF-19, PA-16)
  TextColumn get contentHash => text().nullable()();
  
  // Marca temporal para control de vigencia y sincronización (PS-09)
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [];
}
