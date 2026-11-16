import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers.dart';
import '../../../../core/theme/paper_theme.dart';
import '../providers/catalog_provider.dart';
import '../widgets/pokemon_card.dart';

/// Pantalla del Catálogo de Campo ("Fichero Pokédex", Entregable 6: RF-CAT-01, RF-CAT-04)
///
/// Principios arquitectónicos para la defensa:
/// 1. Fuente de lectura local exclusiva (Entregable 4, OF-16, 17, 18):
///    Observa `pokemonCatalogStreamProvider` de Drift SQLite. Cero llamadas GraphQL en la vista.
/// 2. Estados visuales analógicos (RF-CAT-04):
///    - Carga: Hojas de cartulina en blanco con líneas pautadas de imprenta (sin spinner genérico).
///    - Vacío: Legajo de archivo sin imprimir con botón estampado «DESCARGAR HOJAS DE CAMPO».
///    - Error: Expediente con fallo de registro y botón «REINTENTAR ESTAMPADO».
///    - Éxito: Cuadrícula áurea de fichas de cartulina con ilustraciones risográficas duotono.
class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(pokemonCatalogStreamProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    // Proporciones áureas de ficha de biblioteca (ancho / alto ≈ 0.73)
    final crossAxisCount = screenWidth >= 1000
        ? 5
        : screenWidth >= 750
            ? 4
            : screenWidth >= 500
                ? 3
                : 2;

    return Container(
      color: PaperColors.paperBackgroundLight,
      child: RefreshIndicator(
        color: PaperColors.inkPrimaryLight,
        backgroundColor: PaperColors.cardLight,
        onRefresh: () async {
          // Disparo de sincronización no bloqueante per OF-03 y PA-01
          await ref.read(syncCoordinatorProvider).syncCatalog(force: true);
        },
        child: catalogAsync.when(
          // ESTADO 1: CARGA (Fichas fantasma con líneas pautadas de imprenta)
          loading: () => _buildRuledPaperLoadingGrid(crossAxisCount),

          // ESTADO 2: ERROR (Fallo de registro de imprenta)
          error: (error, _) => _buildArchivalErrorState(context, ref, error),

          // ESTADO 3: ÉXITO O ARCHIVO VACÍO
          data: (pokemons) {
            if (pokemons.isEmpty) {
              return _buildArchivalEmptyState(context, ref);
            }
            return _buildCatalogGrid(context, pokemons, crossAxisCount);
          },
        ),
      ),
    );
  }

  /// Grid de fichas fantasma con líneas pautadas para carga (sin spinner a pantalla completa)
  Widget _buildRuledPaperLoadingGrid(int crossAxisCount) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(PaperColors.inkSecondaryLight),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'CONSULTANDO REGISTRO LOCAL SQLITE...',
                  style: PaperTypography.typewriter(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: PaperColors.inkSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 20),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.73,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _RuledGhostCard(index: index),
              childCount: 6,
            ),
          ),
        ),
      ],
    );
  }

  /// Estado Vacío: Archivo de campo sin especímenes impresos (OF-06)
  Widget _buildArchivalEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: PaperColors.cardLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: PaperColors.cardBorderLight, width: 1.5),
            boxShadow: PaperColors.cardShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Sello de archivo vacío
              Transform.rotate(
                angle: -0.04,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: PaperColors.stampAmber.withValues(alpha: 0.08),
                    border: Border.all(color: PaperColors.stampAmber, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'ARCHIVO VACÍO · SIN REGISTROS',
                    style: PaperTypography.typewriter(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: PaperColors.stampAmber,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'LEGAJO DE CAMPO NO INICIADO',
                textAlign: TextAlign.center,
                style: PaperTypography.naturalistTitle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PaperColors.inkPrimaryLight,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Aún no hay fichas técnicas guardadas en el almacenamiento persistente SQLite. '
                'Pulse el botón para descargar los especímenes desde PokéAPI GraphQL a su base de datos local.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamilyFallback: PaperTypography.serifFallbacks,
                  fontSize: 14,
                  height: 1.45,
                  color: PaperColors.inkSecondaryLight,
                ),
              ),
              const SizedBox(height: 24),
              // Botón con textura de sello de imprenta
              OutlinedButton.icon(
                icon: const Icon(Icons.print, size: 20),
                label: Text(
                  'DESCARGAR HOJAS DE CAMPO',
                  style: PaperTypography.typewriter(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: PaperColors.inkPrimaryLight,
                  backgroundColor: PaperColors.cardLight,
                  side: const BorderSide(color: PaperColors.inkPrimaryLight, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: () {
                  ref.read(syncCoordinatorProvider).syncCatalog(force: true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Estado de Error: Fallo de registro con opción de reintento (RF-CAT-04)
  Widget _buildArchivalErrorState(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: PaperColors.cardLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: PaperColors.stampRed.withValues(alpha: 0.6), width: 1.8),
            boxShadow: PaperColors.cardShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.rotate(
                angle: 0.03,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: PaperColors.stampRed.withValues(alpha: 0.1),
                    border: Border.all(color: PaperColors.stampRed, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'ERROR DE LECTURA DE ARCHIVO',
                    style: PaperTypography.typewriter(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: PaperColors.stampRed,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No fue posible consultar las fichas de campo',
                textAlign: TextAlign.center,
                style: PaperTypography.naturalistTitle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: PaperColors.inkPrimaryLight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: PaperTypography.typewriter(
                  fontSize: 11,
                  color: PaperColors.inkSecondaryLight,
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(
                  'REINTENTAR ESTAMPADO',
                  style: PaperTypography.typewriter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: PaperColors.stampRed,
                  side: const BorderSide(color: PaperColors.stampRed, width: 1.8),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: () {
                  ref.invalidate(pokemonCatalogStreamProvider);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Cuadrícula principal con proporción áurea de fichas de archivo
  Widget _buildCatalogGrid(
    BuildContext context,
    List dynamicPokemons,
    int crossAxisCount,
  ) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        // Encabezado técnico del archivador
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.folder_open, size: 18, color: PaperColors.inkSecondaryLight),
                    const SizedBox(width: 6),
                    Text(
                      'LEGAJO DE CAMPO',
                      style: PaperTypography.typewriter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: PaperColors.inkPrimaryLight,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: PaperColors.cardLight,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: PaperColors.cardBorderLight),
                  ),
                  child: Text(
                    '${dynamicPokemons.length} ESPECÍMENES',
                    style: PaperTypography.typewriter(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: PaperColors.inkSecondaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Cuadrícula virtualizada de fichas
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.73,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final pokemon = dynamicPokemons[index];
                return PokemonCard(pokemon: pokemon);
              },
              childCount: dynamicPokemons.length,
            ),
          ),
        ),
      ],
    );
  }
}

/// Ficha fantasma con líneas pautadas de imprenta (estado de carga analógico)
class _RuledGhostCard extends StatelessWidget {
  final int index;

  const _RuledGhostCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PaperColors.cardLight,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: PaperColors.cardBorderLight, width: 1.2),
        boxShadow: PaperColors.cardShadow,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Número en blanco
          Container(
            width: 44,
            height: 10,
            decoration: BoxDecoration(
              color: PaperColors.inkFaintLight.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Spacer(),
          // Silueta de grabado
          Center(
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: PaperColors.inkFaintLight, width: 1.5),
              ),
              child: const Icon(
                Icons.catching_pokemon,
                color: PaperColors.inkFaintLight,
                size: 32,
              ),
            ),
          ),
          const Spacer(),
          // Líneas pautadas simulando texto en espera de impresión
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: PaperColors.inkFaintLight.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 60,
            height: 8,
            decoration: BoxDecoration(
              color: PaperColors.inkFaintLight.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
