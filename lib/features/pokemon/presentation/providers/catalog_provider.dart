import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/providers.dart';
import '../../domain/entities/pokemon_entity.dart';

/// Estado de los filtros, búsqueda y ordenación del catálogo (RF-FIL-01 a RF-FIL-04)
class CatalogFilterState {
  final String searchQuery;
  final String? selectedType;
  final int? selectedGeneration;
  final String sortBy; // 'id', 'name', 'stats'
  final bool ascending;

  const CatalogFilterState({
    this.searchQuery = '',
    this.selectedType,
    this.selectedGeneration,
    this.sortBy = 'id',
    this.ascending = true,
  });

  CatalogFilterState copyWith({
    String? searchQuery,
    String? selectedType,
    int? selectedGeneration,
    String? sortBy,
    bool? ascending,
    bool clearType = false,
    bool clearGeneration = false,
  }) {
    return CatalogFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
      selectedGeneration: clearGeneration ? null : (selectedGeneration ?? this.selectedGeneration),
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
    );
  }
}

/// Notifier para gestionar la búsqueda con debounce (RF-CAT-03) y persistencia (RF-FIL-04)
class CatalogFilterNotifier extends Notifier<CatalogFilterState> {
  Timer? _debounceTimer;

  static const _prefTypeKey = 'catalog_filter_type';
  static const _prefGenKey = 'catalog_filter_gen';
  static const _prefSortKey = 'catalog_filter_sort';
  static const _prefAscKey = 'catalog_filter_asc';

  @override
  CatalogFilterState build() {
    _loadPersistedFilters();
    return const CatalogFilterState();
  }

  /// Carga filtros persistidos entre sesiones (RF-FIL-04)
  Future<void> _loadPersistedFilters() async {
    final prefs = await SharedPreferences.getInstance();
    final savedType = prefs.getString(_prefTypeKey);
    final savedGen = prefs.getInt(_prefGenKey);
    final savedSort = prefs.getString(_prefSortKey) ?? 'id';
    final savedAsc = prefs.getBool(_prefAscKey) ?? true;

    state = state.copyWith(
      selectedType: savedType,
      selectedGeneration: savedGen,
      sortBy: savedSort,
      ascending: savedAsc,
    );
  }

  /// Búsqueda con debounce de 350 ms (RF-CAT-03: entre 300 y 500 ms)
  void setSearchQuery(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      state = state.copyWith(searchQuery: query.trim());
    });
  }

  void setTypeFilter(String? type) async {
    final prefs = await SharedPreferences.getInstance();
    if (type == null || type == 'all' || type == state.selectedType) {
      await prefs.remove(_prefTypeKey);
      state = state.copyWith(clearType: true);
    } else {
      await prefs.setString(_prefTypeKey, type);
      state = state.copyWith(selectedType: type);
    }
  }

  void setGenerationFilter(int? generation) async {
    final prefs = await SharedPreferences.getInstance();
    if (generation == null || generation == 0 || generation == state.selectedGeneration) {
      await prefs.remove(_prefGenKey);
      state = state.copyWith(clearGeneration: true);
    } else {
      await prefs.setInt(_prefGenKey, generation);
      state = state.copyWith(selectedGeneration: generation);
    }
  }

  void setSortBy(String sortBy, {bool? ascending}) async {
    final prefs = await SharedPreferences.getInstance();
    final isAsc = ascending ?? (state.sortBy == sortBy ? !state.ascending : true);
    await prefs.setString(_prefSortKey, sortBy);
    await prefs.setBool(_prefAscKey, isAsc);
    state = state.copyWith(sortBy: sortBy, ascending: isAsc);
  }

  void resetFilters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefTypeKey);
    await prefs.remove(_prefGenKey);
    await prefs.remove(_prefSortKey);
    await prefs.remove(_prefAscKey);
    state = const CatalogFilterState();
  }
}

final catalogFilterProvider = NotifierProvider<CatalogFilterNotifier, CatalogFilterState>(() {
  return CatalogFilterNotifier();
});

/// Stream de Pokémon del catálogo directamente desde SQLite (Offline-First, RF-CAT-05, RNF-REN-02)
final pokemonCatalogStreamProvider = StreamProvider<List<PokemonListItem>>((ref) {
  final filters = ref.watch(catalogFilterProvider);
  final repository = ref.watch(pokemonRepositoryProvider);

  return repository.watchCatalog(
    search: filters.searchQuery.isEmpty ? null : filters.searchQuery,
    typeFilter: filters.selectedType,
    generationFilter: filters.selectedGeneration,
    sortBy: filters.sortBy,
    ascending: filters.ascending,
  );
});
