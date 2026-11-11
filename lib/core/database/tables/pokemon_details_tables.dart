import 'package:drift/drift.dart';
import 'pokemon_table.dart';

class PokemonTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pokemonId => integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  IntColumn get slot => integer()();
  TextColumn get typeName => text()();
  IntColumn get typeId => integer()();
}

class PokemonStats extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pokemonId => integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  TextColumn get statName => text()();
  IntColumn get baseStat => integer()();
}

class PokemonAbilities extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pokemonId => integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  TextColumn get abilityName => text()();
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();
  TextColumn get shortEffect => text().nullable()();
}

class PokemonMoves extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pokemonId => integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  IntColumn get moveId => integer()();
  TextColumn get moveName => text()();
  TextColumn get typeName => text()();
  IntColumn get power => integer().nullable()();
  IntColumn get accuracy => integer().nullable()();
  IntColumn get pp => integer().nullable()();
  IntColumn get level => integer().withDefault(const Constant(0))();
  TextColumn get learnMethod => text().withDefault(const Constant('level-up'))();
}

class PokemonEvolutions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chainId => integer()();
  IntColumn get speciesId => integer()();
  TextColumn get speciesName => text()();
  IntColumn get evolvesFromId => integer().nullable()();
  TextColumn get triggerName => text().nullable()();
  IntColumn get minLevel => integer().nullable()();
}
