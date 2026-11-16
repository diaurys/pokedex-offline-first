import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers.dart';
import '../providers/catalog_provider.dart';
import '../widgets/pokemon_card.dart';

/// Pantalla del Catálogo de Pokémon (Entregable 6: RF-CAT-01, RF-CAT-04)
///
/// Principios clave para la presentación al profesor:
/// 1. Fuente de lectura local (Entregable 4): Consume `pokemonCatalogStreamProvider`
///    que observa DIRECTAMENTE SQLite con Drift. No llama a GraphQL para pintar.
/// 2. Los 3 estados diferenciados requeridos (RF-CAT-04):
///    - Estado de Carga (Loading)
///    - Estado de Vacío (Empty con botón «Descargar Catálogo», OF-06)
///    - Estado de Error (Error con mensaje y botón «Reintentar»)
/// 3. Funcionamiento Offline (Entregable 7, PA-03, PA-04): Los datos se leen
///    de SQLite, por lo que persisten entre reinicios sin conexión a Internet.
class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observamos el Stream de SQLite mediante Riverpod
    final catalogAsync = ref.watch(pokemonCatalogStreamProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    // Grid responsivo: 2 columnas en móvil, 3 en pantallas medianas, 4 en grandes
    final crossAxisCount = screenWidth >= 900
        ? 4
        : screenWidth >= 600
            ? 3
            : 2;

    return RefreshIndicator(
      color: AppColors.primaryRed,
      onRefresh: () async {
        // Dispara sincronización en segundo plano sin bloquear la UI (OF-03, PA-01)
        await ref.read(syncCoordinatorProvider).syncCatalog(force: true);
      },
      child: catalogAsync.when(
        // ESTADO 1: CARGA (Loading)
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.primaryRed),
              SizedBox(height: 16),
              Text(
                'Consultando base de datos local SQLite...',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),

        // ESTADO 2: ERROR (con opción «Reintentar» per RF-CAT-04)
        error: (error, stack) => Center(
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

        // ESTADO 3: ÉXITO O VACÍO
        data: (pokemons) {
          // Sub-estado: Base de datos vacía (OF-06)
          if (pokemons.isEmpty) {
            return Center(
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
                        'Aún no hay Pokémon en el almacenamiento SQLite local. Pulsa el botón para sincronizar con PokeAPI GraphQL.',
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
                          // Inicia la sincronización remota -> local
                          ref
                              .read(syncCoordinatorProvider)
                              .syncCatalog(force: true);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          // Sub-estado: Éxito con datos locales disponibles (Virtualizado RNF-REN-01)
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Encabezado informativo del estado local
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Catálogo Pokémon',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryRed.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${pokemons.length} en SQLite',
                          style: const TextStyle(
                            color: AppColors.primaryRed,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Cuadrícula virtualizada de tarjetas
              SliverPadding(
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
                      return PokemonCard(pokemon: pokemon);
                    },
                    childCount: pokemons.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
