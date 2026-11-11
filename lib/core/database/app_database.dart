import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/pokemon_table.dart';
import 'tables/pokemon_details_tables.dart';
import 'tables/user_data_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Pokemons,
  PokemonTypes,
  PokemonStats,
  PokemonAbilities,
  PokemonMoves,
  PokemonEvolutions,
  Favorites,
  TriviaRecords,
  SyncMetadata,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'pokedex_database',
      native: const DriftNativeOptions(
        shareAcrossIsolates: true,
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Creación explícita de índices para optimizar búsquedas y filtros (RNF-REN-02)
        await customStatement('CREATE INDEX IF NOT EXISTS idx_pokemons_name ON pokemons(name);');
        await customStatement('CREATE INDEX IF NOT EXISTS idx_pokemons_generation ON pokemons(generation_id);');
        await customStatement('CREATE INDEX IF NOT EXISTS idx_pokemon_types_name ON pokemon_types(type_name);');
        await customStatement('CREATE INDEX IF NOT EXISTS idx_pokemon_types_pokemon_id ON pokemon_types(pokemon_id);');
        await customStatement('CREATE INDEX IF NOT EXISTS idx_pokemon_stats_pokemon_id ON pokemon_stats(pokemon_id);');
      },
    );
  }
}
