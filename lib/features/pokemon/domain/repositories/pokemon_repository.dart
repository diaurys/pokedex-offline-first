import '../entities/pokemon_entity.dart';

abstract class PokemonRepository {
  /// Observa el catálogo directamente desde la base local reactiva (P-01, OF-16)
  Stream<List<PokemonListItem>> watchCatalog({
    String? search,
    String? typeFilter,
    int? generationFilter,
    String sortBy = 'id',
    bool ascending = true,
  });

  /// Observa el detalle de un Pokémon desde la base local
  Stream<PokemonDetail?> watchPokemonDetail(int id);

  /// Sincroniza el catálogo en segundo plano (remoto -> local)
  Future<bool> syncCatalog({int limit = 24, int offset = 0, bool force = false});

  /// Sincroniza los detalles completos de un Pokémon
  Future<bool> syncPokemonDetail(int id);

  /// Detecta y restaura si los datos locales fueron alterados (OF-19, PA-16)
  Future<bool> checkAndRestoreIfTampered(int id);

  /// Obtiene la cantidad de Pokémon persistidos en la base local
  Future<int> getStoredCount();

  /// Obtiene Pokémon almacenados para la trivia
  Future<List<PokemonListItem>> getPokemonsForTrivia({int limit = 20});
}
