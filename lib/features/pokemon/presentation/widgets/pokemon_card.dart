import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers.dart';
import '../../domain/entities/pokemon_entity.dart';

/// Tarjeta visual de Pokémon para el Catálogo (Entregable 6: RF-CAT-01)
/// Muestra:
/// - Nombre y Número de Pokédex (#001)
/// - Imagen oficial con respaldo triple (OF-08)
/// - Badges de Tipos
/// - Fondo con gradiente dinámico derivado del tipo principal
/// - Botón de favorito reactivo que persiste en SQLite (<150ms, Entregable 2)
class PokemonCard extends ConsumerStatefulWidget {
  final PokemonListItem pokemon;

  const PokemonCard({
    super.key,
    required this.pokemon,
  });

  @override
  ConsumerState<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends ConsumerState<PokemonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _favAnimController;
  late Animation<double> _favScaleAnim;

  @override
  void initState() {
    super.initState();
    _favAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _favScaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.35), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _favAnimController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _favAnimController.dispose();
    super.dispose();
  }

  void _onToggleFavorite() async {
    _favAnimController.forward(from: 0.0);
    // Persistencia reactiva instantánea en SQLite (<150ms per Entregable 2)
    await ref.read(favoritesRepositoryProvider).toggleFavorite(widget.pokemon.id);
  }

  void _showQuickInfoModal(BuildContext context) {
    final typeColor = AppColors.forType(widget.pokemon.primaryType);
    final formattedName = widget.pokemon.name.isNotEmpty
        ? '${widget.pokemon.name[0].toUpperCase()}${widget.pokemon.name.substring(1)}'
        : '';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedName,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.pokemon.formattedNumber,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: typeColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: CachedNetworkImage(
                  imageUrl: widget.pokemon.officialArtwork,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/pokeball_placeholder.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: widget.pokemon.types.map((type) {
                  final color = AppColors.forType(type);
                  return Chip(
                    backgroundColor: color.withValues(alpha: 0.2),
                    side: BorderSide(color: color),
                    label: Text(
                      type.toUpperCase(),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Altura', '${widget.pokemon.height / 10} m'),
                  _buildStatItem('Peso', '${widget.pokemon.weight / 10} kg'),
                  _buildStatItem('Generación', 'Gen ${widget.pokemon.generationId}'),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = AppColors.forType(widget.pokemon.primaryType);
    final formattedName = widget.pokemon.name.isNotEmpty
        ? '${widget.pokemon.name[0].toUpperCase()}${widget.pokemon.name.substring(1)}'
        : '';

    final semanticsLabel =
        'Pokémon $formattedName, número ${widget.pokemon.id}, tipos ${widget.pokemon.types.join(' y ')}${widget.pokemon.isFavorite ? ', guardado en favoritos' : ''}';

    return Semantics(
      label: semanticsLabel,
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showQuickInfoModal(context),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  typeColor.withValues(alpha: 0.88),
                  typeColor,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: typeColor.withValues(alpha: 0.35),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // 1. Marca de agua decorativa Pokéball en el fondo
                Positioned(
                  right: -24,
                  bottom: -24,
                  child: Opacity(
                    opacity: 0.18,
                    child: const Icon(
                      Icons.catching_pokemon,
                      size: 130,
                      color: Colors.white,
                    ),
                  ),
                ),

                // 2. Número de Pokédex arriba a la derecha (#001)
                Positioned(
                  top: 10,
                  right: 12,
                  child: Text(
                    widget.pokemon.formattedNumber,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                // 3. Contenido principal (Nombre, Tipos, Imagen y Favorito)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre del Pokémon
                      Text(
                        formattedName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Chips de tipos (1 o 2 tipos per RF-CAT-01)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.pokemon.types.map((type) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              type.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const Spacer(),

                      // Fila inferior: Botón favorito + Imagen con respaldos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Botón de favorito reactivo (<150ms per Entregable 2)
                          ScaleTransition(
                            scale: _favScaleAnim,
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.25),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 20,
                                icon: Icon(
                                  widget.pokemon.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: widget.pokemon.isFavorite
                                      ? const Color(0xFFFF3366)
                                      : Colors.white,
                                ),
                                tooltip: widget.pokemon.isFavorite
                                    ? 'Quitar de favoritos'
                                    : 'Agregar a favoritos',
                                onPressed: _onToggleFavorite,
                              ),
                            ),
                          ),

                          // Imagen oficial con 3 niveles de respaldo (OF-08 / RF-CAT-01)
                          SizedBox(
                            width: 82,
                            height: 82,
                            child: CachedNetworkImage(
                              imageUrl: widget.pokemon.officialArtwork,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white.withValues(alpha: 0.6),
                                    ),
                                  ),
                                ),
                              ),
                              // Respaldo 1: Sprite si official-artwork falla
                              errorWidget: (context, url, error) {
                                return CachedNetworkImage(
                                  imageUrl: widget.pokemon.spriteUrl,
                                  fit: BoxFit.contain,
                                  // Respaldo 2: Asset local offline si no hay red ni sprite (OF-08)
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
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
