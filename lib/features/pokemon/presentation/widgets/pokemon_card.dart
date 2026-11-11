import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers.dart';
import '../../domain/entities/pokemon_entity.dart';

/// Tarjeta moderna de Pokémon para el catálogo (RF-CAT-01, RF-CAT-07, RF-COM-02, RF-FAV-04)
class PokemonCard extends ConsumerStatefulWidget {
  final PokemonListItem pokemon;
  final VoidCallback? onTap;

  const PokemonCard({
    super.key,
    required this.pokemon,
    this.onTap,
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
    // Persistencia reactiva instantánea en SQLite (<150ms per RF-FAV-04)
    await ref.read(favoritesRepositoryProvider).toggleFavorite(widget.pokemon.id);
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = AppColors.forType(widget.pokemon.primaryType);
    final formattedName = widget.pokemon.name.isNotEmpty
        ? '${widget.pokemon.name[0].toUpperCase()}${widget.pokemon.name.substring(1)}'
        : '';

    // Accesibilidad RNF-ACC-01
    final semanticsLabel =
        'Pokémon $formattedName, número ${widget.pokemon.id}, tipos ${widget.pokemon.types.join(' y ')}${widget.pokemon.isFavorite ? ', en favoritos' : ''}';

    return Semantics(
      label: semanticsLabel,
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
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
                // 1. Marca de agua decorativa Pokéball de fondo
                Positioned(
                  right: -24,
                  bottom: -24,
                  child: Opacity(
                    opacity: 0.18,
                    child: Icon(
                      Icons.catching_pokemon,
                      size: 130,
                      color: Colors.white,
                    ),
                  ),
                ),

                // 2. Número de Pokédex arriba a la derecha (sutil)
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

                // 3. Contenido principal (Nombre, Tipos, Imagen)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre
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

                      // Chips de tipos
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

                      // Fila inferior: Botón favorito + Imagen con Hero
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Botón de favorito con animación (RF-COM-03, RF-FAV-04)
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

                          // Imagen con Hero animation (RF-COM-02) y fallback OF-08
                          Hero(
                            tag: 'pokemon-artwork-${widget.pokemon.id}',
                            child: SizedBox(
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
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
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
                                    // Respaldo 2: Asset local si no hay red ni sprite (OF-08)
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
