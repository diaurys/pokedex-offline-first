import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers.dart';
import '../providers/catalog_provider.dart';
import '../widgets/pokemon_card.dart';
import 'pokemon_detail_screen.dart';

/// Pantalla principal del Catálogo de Pokémon (RF-CAT-01 a RF-CAT-06, RF-FIL-01 a RF-FIL-05)
class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const List<String> _pokemonTypes = [
    'normal',
    'fire',
    'water',
    'grass',
    'electric',
    'ice',
    'fighting',
    'poison',
    'ground',
    'flying',
    'psychic',
    'bug',
    'rock',
    'ghost',
    'dragon',
    'steel',
    'fairy',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSortDialog() {
    final currentFilters = ref.read(catalogFilterProvider);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    'Ordenar Pokémon por:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.tag),
                  title: const Text('Número de Pokédex (#)'),
                  trailing: currentFilters.sortBy == 'id'
                      ? Icon(
                          currentFilters.ascending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: AppColors.primaryRed,
                        )
                      : null,
                  onTap: () {
                    ref.read(catalogFilterProvider.notifier).setSortBy('id');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.sort_by_alpha),
                  title: const Text('Nombre (A-Z)'),
                  trailing: currentFilters.sortBy == 'name'
                      ? Icon(
                          currentFilters.ascending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: AppColors.primaryRed,
                        )
                      : null,
                  onTap: () {
                    ref.read(catalogFilterProvider.notifier).setSortBy('name');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bar_chart),
                  title: const Text('Estadísticas Base Totales (BST)'),
                  trailing: currentFilters.sortBy == 'stats'
                      ? Icon(
                          currentFilters.ascending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: AppColors.primaryRed,
                        )
                      : null,
                  onTap: () {
                    ref.read(catalogFilterProvider.notifier).setSortBy('stats');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showGenerationDialog() {
    final currentFilters = ref.read(catalogFilterProvider);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    'Filtrar por Generación:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10, // 0 = Todas, 1-9 = Gens
                    itemBuilder: (context, index) {
                      final isAll = index == 0;
                      final isSelected = isAll
                          ? currentFilters.selectedGeneration == null
                          : currentFilters.selectedGeneration == index;

                      return ListTile(
                        leading: Icon(
                          Icons.catching_pokemon,
                          color: isSelected ? AppColors.primaryRed : Colors.grey,
                        ),
                        title: Text(
                          isAll ? 'Todas las Generaciones' : 'Generación $index',
                          style: TextStyle(
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppColors.primaryRed : null,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: AppColors.primaryRed)
                            : null,
                        onTap: () {
                          ref
                              .read(catalogFilterProvider.notifier)
                              .setGenerationFilter(isAll ? null : index);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(catalogFilterProvider);
    final catalogAsync = ref.watch(pokemonCatalogStreamProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive grid: 2 columnas en móvil, 3 en pantallas medianas, 4 en grandes (RF-CAT-06)
    final crossAxisCount = screenWidth >= 900
        ? 4
        : screenWidth >= 600
            ? 3
            : 2;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: RefreshIndicator(
        color: AppColors.primaryRed,
        onRefresh: () async {
          await ref.read(syncCoordinatorProvider).syncCatalog(force: true);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // 1. Barra de Búsqueda y Filtros
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Column(
                  children: [
                    // Campo de Búsqueda (RF-CAT-03 con debounce 350ms)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          ref
                              .read(catalogFilterProvider.notifier)
                              .setSearchQuery(val);
                        },
                        decoration: InputDecoration(
                          hintText: 'Buscar por nombre o número...',
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, color: Colors.grey),
                                  onPressed: () {
                                    _searchController.clear();
                                    ref
                                        .read(catalogFilterProvider.notifier)
                                        .setSearchQuery('');
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Fila de acciones rápidas (Generación, Orden, Limpiar)
                    Row(
                      children: [
                        // Botón Generación
                        OutlinedButton.icon(
                          icon: const Icon(Icons.layers, size: 16),
                          label: Text(
                            filterState.selectedGeneration != null
                                ? 'Gen ${filterState.selectedGeneration}'
                                : 'Generación',
                            style: const TextStyle(fontSize: 12),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: filterState.selectedGeneration != null
                                ? AppColors.primaryRed
                                : Colors.black87,
                            side: BorderSide(
                              color: filterState.selectedGeneration != null
                                  ? AppColors.primaryRed
                                  : Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                          ),
                          onPressed: _showGenerationDialog,
                        ),
                        const SizedBox(width: 8),

                        // Botón Orden
                        OutlinedButton.icon(
                          icon: const Icon(Icons.sort, size: 16),
                          label: Text(
                            filterState.sortBy == 'name'
                                ? 'Nombre'
                                : filterState.sortBy == 'stats'
                                    ? 'Estadísticas'
                                    : 'Número',
                            style: const TextStyle(fontSize: 12),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black87,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                          ),
                          onPressed: _showSortDialog,
                        ),

                        const Spacer(),

                        // Botón Limpiar Filtros si hay alguno activo
                        if (filterState.selectedType != null ||
                            filterState.selectedGeneration != null ||
                            filterState.searchQuery.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              _searchController.clear();
                              ref
                                  .read(catalogFilterProvider.notifier)
                                  .resetFilters();
                            },
                            child: const Text(
                              'Limpiar',
                              style: TextStyle(
                                color: AppColors.primaryRed,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 2. Carrusel Horizontal de Tipos (RF-FIL-01)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _pokemonTypes.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final isSelected = filterState.selectedType == null;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: const Text('Todos'),
                          selected: isSelected,
                          onSelected: (_) {
                            ref
                                .read(catalogFilterProvider.notifier)
                                .setTypeFilter(null);
                          },
                          selectedColor: AppColors.primaryRed.withValues(alpha: 0.2),
                          checkmarkColor: AppColors.primaryRed,
                          labelStyle: TextStyle(
                            color: isSelected ? AppColors.primaryRed : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }

                    final type = _pokemonTypes[index - 1];
                    final isSelected = filterState.selectedType == type;
                    final typeColor = AppColors.forType(type);

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(type.toUpperCase()),
                        selected: isSelected,
                        onSelected: (_) {
                          ref
                              .read(catalogFilterProvider.notifier)
                              .setTypeFilter(type);
                        },
                        backgroundColor: Colors.white,
                        selectedColor: typeColor.withValues(alpha: 0.25),
                        checkmarkColor: typeColor,
                        side: BorderSide(
                          color: isSelected ? typeColor : Colors.grey.shade300,
                          width: isSelected ? 1.5 : 1.0,
                        ),
                        labelStyle: TextStyle(
                          color: isSelected ? typeColor : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 11,
                          letterSpacing: 0.3,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),

            // 3. GridView virtualizado del Catálogo (RNF-REN-01, RF-CAT-04)
            catalogAsync.when(
              loading: () => const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: AppColors.primaryRed),
                      SizedBox(height: 16),
                      Text(
                        'Cargando Pokédex local...',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              error: (error, stack) => SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: AppColors.statusOffline,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Ocurrió un error al consultar el catálogo',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reintentar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryRed,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              ref.invalidate(pokemonCatalogStreamProvider);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              data: (pokemons) {
                // Estado 1: Base de datos vacía (OF-06, RF-CAT-04)
                if (pokemons.isEmpty &&
                    filterState.searchQuery.isEmpty &&
                    filterState.selectedType == null &&
                    filterState.selectedGeneration == null) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.catching_pokemon,
                                size: 90,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Base de datos local vacía',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Aún no hay Pokémon descargados en el almacenamiento local SQLite. Pulsa el botón para sincronizar el catálogo.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.cloud_download),
                                label: const Text('Descargar Catálogo'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryRed,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  ref
                                      .read(syncCoordinatorProvider)
                                      .syncCatalog(force: true);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                // Estado 2: Búsqueda sin resultados
                if (pokemons.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search_off,
                                size: 70,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'No se encontraron Pokémon',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Prueba ajustando los filtros de tipo, generación o el término de búsqueda.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 16),
                              OutlinedButton(
                                onPressed: () {
                                  _searchController.clear();
                                  ref
                                      .read(catalogFilterProvider.notifier)
                                      .resetFilters();
                                },
                                child: const Text('Limpiar Filtros'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                // Estado 3: Éxito con lista virtualizada (RNF-REN-01)
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.95,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final pokemon = pokemons[index];
                        return PokemonCard(
                          pokemon: pokemon,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PokemonDetailScreen(
                                  pokemonId: pokemon.id,
                                  initialName: pokemon.name,
                                  initialType: pokemon.primaryType,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      childCount: pokemons.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
