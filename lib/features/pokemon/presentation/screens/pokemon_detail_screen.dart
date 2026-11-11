import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers.dart';
import '../../../../core/utils/type_matchups_helper.dart';
import '../../domain/entities/pokemon_entity.dart';

/// StreamProvider para observar el detalle de un Pokémon desde la base local SQLite (OF-02, RF-DET)
final pokemonDetailStreamProvider =
    StreamProvider.family<PokemonDetail?, int>((ref, pokemonId) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.watchPokemonDetail(pokemonId);
});

/// Pantalla completa de Detalle de Pokémon (RF-DET-01 a RF-DET-10, OF-19, RF-COM-01)
class PokemonDetailScreen extends ConsumerStatefulWidget {
  final int pokemonId;
  final String initialName;
  final String initialType;

  const PokemonDetailScreen({
    super.key,
    required this.pokemonId,
    required this.initialName,
    required this.initialType,
  });

  @override
  ConsumerState<PokemonDetailScreen> createState() =>
      _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends ConsumerState<PokemonDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showShiny = false; // Alternancia shiny (RF-DET-09)
  bool _useRadarChart = false; // Alternancia barras / radar para stats (RF-DET-02)

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Dispara sincronización en segundo plano de los detalles completos si no están en local
    Future.microtask(() {
      ref.read(syncCoordinatorProvider).syncPokemonDetail(widget.pokemonId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _sharePokemon(PokemonDetail? pokemon) {
    if (pokemon == null) return;
    final name =
        pokemon.name[0].toUpperCase() + pokemon.name.substring(1).toLowerCase();
    final types = pokemon.types.map((t) => t.name.toUpperCase()).join(', ');
    final bst = pokemon.totalBaseStats;

    SharePlus.instance.share(
      ShareParams(
        text: '🌟 ¡Mira este Pokémon en la Pokédex Offline-First! 🌟\n\n'
            '#${pokemon.formattedNumber} $name\n'
            'Tipos: $types\n'
            'Total Estadísticas Base: $bst\n'
            'Altura: ${pokemon.heightMeters} m | Peso: ${pokemon.weightKg} kg\n\n'
            '${pokemon.flavorText ?? ""}',
        subject: 'Pokédex - $name',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync =
        ref.watch(pokemonDetailStreamProvider(widget.pokemonId));

    return detailAsync.when(
      loading: () => _buildScaffoldWithHeader(
        context,
        pokemon: null,
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.primaryRed),
        ),
      ),
      error: (error, _) => _buildScaffoldWithHeader(
        context,
        pokemon: null,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    size: 60, color: AppColors.statusOffline),
                const SizedBox(height: 16),
                Text('Error al cargar detalle: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(
                        pokemonDetailStreamProvider(widget.pokemonId));
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      ),
      data: (pokemon) => _buildScaffoldWithHeader(
        context,
        pokemon: pokemon,
        body: pokemon == null
            ? const Center(child: Text('Pokémon no disponible localmente'))
            : _buildDetailContent(context, pokemon),
      ),
    );
  }

  Widget _buildScaffoldWithHeader(
    BuildContext context, {
    required PokemonDetail? pokemon,
    required Widget body,
  }) {
    final primaryType = pokemon?.primaryType ?? widget.initialType;
    final themeColor = AppColors.forType(primaryType);
    final pokemonName = pokemon != null
        ? '${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}'
        : widget.initialName;
    final formattedNumber =
        pokemon?.formattedNumber ?? '#${widget.pokemonId.toString().padLeft(3, '0')}';

    final artworkUrl = _showShiny
        ? (pokemon?.officialArtworkShiny ??
            ApiConstants.officialArtworkShinyUrl(widget.pokemonId))
        : (pokemon?.officialArtwork ??
            ApiConstants.officialArtworkUrl(widget.pokemonId));

    final spriteUrl = _showShiny
        ? (pokemon?.spriteShinyUrl ??
            ApiConstants.spriteShinyFallbackUrl(widget.pokemonId))
        : (pokemon?.spriteUrl ??
            ApiConstants.spriteFallbackUrl(widget.pokemonId));

    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          // Botón Shiny toggle (RF-DET-09)
          IconButton(
            icon: Icon(
              _showShiny ? Icons.auto_awesome : Icons.auto_awesome_outlined,
              color: _showShiny ? AppColors.pokeYellow : Colors.white,
            ),
            tooltip: _showShiny ? 'Ver Normal' : 'Ver Shiny',
            onPressed: () {
              setState(() {
                _showShiny = !_showShiny;
              });
            },
          ),

          // Botón Favorito (RF-DET-10, RF-FAV-04)
          if (pokemon != null)
            IconButton(
              icon: Icon(
                pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: pokemon.isFavorite
                    ? const Color(0xFFFF3366)
                    : Colors.white,
              ),
              tooltip: pokemon.isFavorite
                  ? 'Quitar de favoritos'
                  : 'Agregar a favoritos',
              onPressed: () async {
                await ref
                    .read(favoritesRepositoryProvider)
                    .toggleFavorite(pokemon.id);
              },
            ),

          // Botón Compartir tarjeta (RF-COM-01, RF-DET-10)
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Compartir Pokémon',
            onPressed: () => _sharePokemon(pokemon),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. Fondo superior decorativo con Pokéball y datos de cabecera
          Positioned(
            top: -20,
            right: -20,
            child: Opacity(
              opacity: 0.15,
              child: const Icon(
                Icons.catching_pokemon,
                size: 260,
                color: Colors.white,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera: Nombre, Tipos y Número
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            pokemonName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Text(
                          formattedNumber,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Tipos (1 o 2 tipos per RF-DET-01)
                    Row(
                      children: (pokemon?.types ??
                              [
                                PokemonTypeEntity(
                                    id: 1, name: widget.initialType, slot: 1)
                              ])
                          .map((t) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.28),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            t.name.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.5,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Alerta si los datos fueron alterados en SQLite (OF-19, PA-16)
              if (pokemon != null && pokemon.isTampered)
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Datos locales alterados (OF-19).',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                        ),
                        onPressed: () async {
                          await ref
                              .read(syncCoordinatorProvider)
                              .checkAndRestoreIfTampered(pokemon.id);
                        },
                        child: const Text('Restaurar',
                            style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                ),

              // Imagen central con Hero (RF-COM-02) y soporte Shiny (RF-DET-09)
              Center(
                child: Hero(
                  tag: 'pokemon-artwork-${widget.pokemonId}',
                  child: SizedBox(
                    height: 180,
                    width: 180,
                    child: CachedNetworkImage(
                      imageUrl: artworkUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                      // Respaldo 1: Sprite si official-artwork no carga (RF-DET-01)
                      errorWidget: (context, url, error) {
                        return CachedNetworkImage(
                          imageUrl: spriteUrl,
                          fit: BoxFit.contain,
                          // Respaldo 2: Asset local offline (OF-08)
                          errorWidget: (context, url2, error2) {
                            return Image.asset(
                              'assets/images/pokeball_placeholder.png',
                              fit: BoxFit.contain,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),

              // 2. Tarjeta blanca inferior deslizable con pestañas
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Pestañas
                      TabBar(
                        controller: _tabController,
                        labelColor: themeColor,
                        unselectedLabelColor: Colors.black45,
                        indicatorColor: themeColor,
                        indicatorWeight: 3,
                        tabs: const [
                          Tab(text: 'Estadísticas'),
                          Tab(text: 'Evolución & Matchups'),
                          Tab(text: 'Movimientos'),
                        ],
                      ),

                      // Contenido de las pestañas
                      Expanded(
                        child: body,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailContent(BuildContext context, PokemonDetail pokemon) {
    return TabBarView(
      controller: _tabController,
      children: [
        // Pestaña 1: Metadatos y Estadísticas Base (RF-DET-02, RF-DET-07)
        _buildStatsTab(pokemon),

        // Pestaña 2: Cadena evolutiva y Matchups defensivos (RF-DET-04, RF-DET-06)
        _buildEvolutionsAndMatchupsTab(pokemon),

        // Pestaña 3: Habilidades y Movimientos (RF-DET-03, RF-DET-05)
        _buildMovesAndAbilitiesTab(pokemon),
      ],
    );
  }

  // --- PESTAÑA 1: METADATOS Y STATS (RF-DET-02, RF-DET-07) ---
  Widget _buildStatsTab(PokemonDetail pokemon) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Descripción de especie (Flavor text)
          if (pokemon.flavorText != null && pokemon.flavorText!.isNotEmpty) ...[
            Text(
              pokemon.flavorText!,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black87,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Metadatos físicos (Altura, Peso, Generación) (RF-DET-07)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetaItem(
                  icon: Icons.height,
                  label: 'Altura',
                  value: '${pokemon.heightMeters.toStringAsFixed(1)} m',
                ),
                Container(height: 35, width: 1, color: Colors.grey.shade300),
                _buildMetaItem(
                  icon: Icons.scale,
                  label: 'Peso',
                  value: '${pokemon.weightKg.toStringAsFixed(1)} kg',
                ),
                Container(height: 35, width: 1, color: Colors.grey.shade300),
                _buildMetaItem(
                  icon: Icons.layers,
                  label: 'Generación',
                  value: 'Gen ${pokemon.generationId}',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Título de Estadísticas con selector Radar / Barras (RF-DET-02)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Estadísticas Base',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(
                  _useRadarChart ? Icons.bar_chart : Icons.radar,
                  color: AppColors.forType(pokemon.primaryType),
                ),
                tooltip: _useRadarChart ? 'Ver Barras' : 'Ver Radar',
                onPressed: () {
                  setState(() {
                    _useRadarChart = !_useRadarChart;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Gráfico Radar (fl_chart) o Barras horizontales (RF-DET-02)
          if (_useRadarChart && pokemon.stats.isNotEmpty)
            SizedBox(
              height: 220,
              child: RadarChart(
                RadarChartData(
                  dataSets: [
                    RadarDataSet(
                      fillColor: AppColors.forType(pokemon.primaryType)
                          .withValues(alpha: 0.35),
                      borderColor: AppColors.forType(pokemon.primaryType),
                      borderWidth: 2,
                      entryRadius: 3,
                      dataEntries: pokemon.stats
                          .map((s) => RadarEntry(value: s.value.toDouble()))
                          .toList(),
                    ),
                  ],
                  radarBackgroundColor: Colors.transparent,
                  borderData: FlBorderData(show: false),
                  radarBorderData:
                      const BorderSide(color: Colors.black12, width: 1),
                  titlePositionPercentageOffset: 0.2,
                  titleTextStyle:
                      const TextStyle(color: Colors.black87, fontSize: 11),
                  getTitle: (index, angle) {
                    if (index >= 0 && index < pokemon.stats.length) {
                      return RadarChartTitle(
                        text: pokemon.stats[index].displayName,
                        angle: angle,
                      );
                    }
                    return const RadarChartTitle(text: '');
                  },
                  tickCount: 4,
                  ticksTextStyle: const TextStyle(color: Colors.transparent),
                ),
              ),
            )
          else ...[
            // Barras animadas con porcentaje y valor visible (RF-DET-02)
            ...pokemon.stats.map((stat) {
              final pct = (stat.value / 255.0).clamp(0.0, 1.0);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 85,
                      child: Text(
                        stat.displayName,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 38,
                      child: Text(
                        stat.value.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: pct,
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            stat.value >= 100
                                ? AppColors.statusOnline
                                : stat.value >= 60
                                    ? AppColors.forType(pokemon.primaryType)
                                    : Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(pct * 100).toInt()}%',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }),
          ],

          const SizedBox(height: 12),
          // Total de estadísticas base visible (RF-DET-02)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Estadísticas Base (BST):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  pokemon.totalBaseStats.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppColors.forType(pokemon.primaryType),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.black54),
            const SizedBox(width: 4),
            Text(label,
                style: const TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }

  // --- PESTAÑA 2: EVOLUCIONES Y MATCHUPS (RF-DET-04, RF-DET-06) ---
  Widget _buildEvolutionsAndMatchupsTab(PokemonDetail pokemon) {
    final typeNames = pokemon.types.map((t) => t.name).toList();
    final defenseMatchups =
        TypeMatchupsHelper.calculateDefenseMatchups(typeNames);

    final weak = <String, double>{}; // x4, x2
    final resist = <String, double>{}; // x0.5, x0.25
    final immune = <String, double>{}; // x0

    defenseMatchups.forEach((type, mult) {
      if (mult > 1.0) {
        weak[type] = mult;
      } else if (mult == 0.0) {
        immune[type] = mult;
      } else if (mult < 1.0) {
        resist[type] = mult;
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Cadena de Evolución (RF-DET-04)
          const Text(
            'Línea de Evolución',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          if (pokemon.evolutions.isEmpty || pokemon.evolutions.length <= 1)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Este Pokémon no evoluciona',
                  style: TextStyle(
                      color: Colors.black54, fontStyle: FontStyle.italic),
                ),
              ),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: pokemon.evolutions.map((evo) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 75,
                            height: 75,
                            color: Colors.grey.shade100,
                            child: CachedNetworkImage(
                              imageUrl: evo.imageUrl,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.catching_pokemon,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          evo.speciesName[0].toUpperCase() +
                              evo.speciesName.substring(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        if (evo.minLevel != null)
                          Text(
                            'Nv. ${evo.minLevel}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

          const SizedBox(height: 24),

          // 2. Matchups defensivos por tipo (RF-DET-06)
          const Text(
            'Efectividad Defensiva (Daño Recibido)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Multiplicador de daño recibido según los tipos de este Pokémon:',
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          const SizedBox(height: 14),

          // Débil contra (x2, x4)
          _buildMatchupSection('Débil contra (×2, ×4)', weak, Colors.red.shade700),
          const SizedBox(height: 12),

          // Resistente contra (x0.5, x0.25)
          _buildMatchupSection(
              'Resistente contra (×0.5, ×0.25)', resist, Colors.green.shade700),
          const SizedBox(height: 12),

          // Inmune contra (x0)
          if (immune.isNotEmpty)
            _buildMatchupSection('Inmune contra (×0)', immune, Colors.blueGrey),
        ],
      ),
    );
  }

  Widget _buildMatchupSection(
      String title, Map<String, double> types, Color headerColor) {
    if (types.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: headerColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: types.entries.map((entry) {
            final typeColor = AppColors.forType(entry.key);
            final multStr = entry.value == 0.0
                ? '0×'
                : entry.value == 0.25
                    ? '¼×'
                    : entry.value == 0.5
                        ? '½×'
                        : '${entry.value.toInt()}×';

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: typeColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    entry.key.toUpperCase(),
                    style: TextStyle(
                      color: typeColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: typeColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      multStr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // --- PESTAÑA 3: HABILIDADES Y MOVIMIENTOS (RF-DET-03, RF-DET-05) ---
  Widget _buildMovesAndAbilitiesTab(PokemonDetail pokemon) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        // Habilidades (RF-DET-03)
        const Text(
          'Habilidades',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...pokemon.abilities.map((ability) {
          final abilityName =
              ability.name[0].toUpperCase() + ability.name.substring(1);
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      abilityName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (ability.isHidden) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Oculta',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (ability.shortEffect != null &&
                    ability.shortEffect!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    // Limitar a 160 caracteres según RF-DET-03
                    ability.shortEffect!.length > 160
                        ? '${ability.shortEffect!.substring(0, 157)}...'
                        : ability.shortEffect!,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),
                ],
              ],
            ),
          );
        }),

        const SizedBox(height: 20),

        // Movimientos (RF-DET-05, lista virtualizada de al menos 20 elementos)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Movimientos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '${pokemon.moves.length} disponibles',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 10),

        if (pokemon.moves.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'No hay movimientos registrados para esta versión',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          )
        else
          ...pokemon.moves.map((move) {
            final moveColor = AppColors.forType(move.typeName);
            final moveName =
                move.name[0].toUpperCase() + move.name.substring(1);

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  // Nivel o método de aprendizaje
                  Container(
                    width: 44,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      move.level > 0 ? 'Nv. ${move.level}' : 'MT',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Nombre del movimiento
                  Expanded(
                    child: Text(
                      moveName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),

                  // Tipo del movimiento
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: moveColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      move.typeName.toUpperCase(),
                      style: TextStyle(
                        color: moveColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Potencia
                  SizedBox(
                    width: 32,
                    child: Text(
                      move.power != null ? '${move.power}' : '-',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }
}
