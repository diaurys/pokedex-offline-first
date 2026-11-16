import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers.dart';
import '../../../../core/theme/paper_theme.dart';
import '../../domain/entities/pokemon_entity.dart';
import 'paperclip_widget.dart';
import 'risograph_artwork.dart';

/// Ficha de Cartulina de Naturalista (Entregable 6: RF-CAT-01, RF-CAT-04)
/// Diseño: "Fichero Pokédex"
/// - Papel Manila con sombra física
/// - Número mecanografiado ("N.º 025")
/// - Grabado en duotono risográfico con desalineado de registro
/// - Clip de latón envejecido para favoritos
/// - Sellos taxonómicos con glifo geométrico grabado
class PokemonCard extends ConsumerWidget {
  final PokemonListItem pokemon;

  const PokemonCard({
    super.key,
    required this.pokemon,
  });

  String _formatTypewriterNumber(int id) {
    return 'N.º ${id.toString().padLeft(3, '0')}';
  }

  void _onToggleFavorite(WidgetRef ref) async {
    // Persistencia reactiva instantánea en SQLite (<150ms per Entregable 2)
    await ref.read(favoritesRepositoryProvider).toggleFavorite(pokemon.id);
  }

  void _showFieldDossierModal(BuildContext context, WidgetRef ref) {
    final typeColor = AppColors.forType(pokemon.primaryType);
    final formattedName = pokemon.name.isNotEmpty
        ? '${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}'
        : '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: PaperColors.cardLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        side: BorderSide(color: PaperColors.cardBorderLight, width: 1.5),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pestaña superior del archivador
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: PaperColors.inkFaintLight,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Cabecera de expediente
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatTypewriterNumber(pokemon.id),
                            style: PaperTypography.typewriter(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: PaperColors.inkSecondaryLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            formattedName,
                            style: PaperTypography.naturalistTitle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: PaperColors.inkPrimaryLight,
                            ),
                          ),
                        ],
                      ),
                      PaperclipWidget(
                        size: 32,
                        isFavorite: pokemon.isFavorite,
                        onTap: () {
                          _onToggleFavorite(ref);
                          Navigator.pop(ctx);
                        },
                      ),
                    ],
                  ),

                  const Divider(color: PaperColors.inkFaintLight, thickness: 1, height: 24),

                  // Ilustración en Risografía Duotono ampliada
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: PaperColors.paperBackgroundLight,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: PaperColors.cardBorderLight),
                      ),
                      child: RisographArtwork(
                        imageUrl: pokemon.officialArtwork,
                        spriteUrl: pokemon.spriteUrl,
                        primaryTypeColor: typeColor,
                        size: 140,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Sellos taxonómicos de tipos
                  Center(
                    child: Wrap(
                      spacing: 8,
                      children: pokemon.types.map((type) {
                        final color = AppColors.forType(type);
                        final glyph = AppColors.glyphForType(type);
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.08),
                            border: Border.all(color: color, width: 1.4),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(glyph, style: TextStyle(color: color, fontSize: 13)),
                              const SizedBox(width: 5),
                              Text(
                                type.toUpperCase(),
                                style: PaperTypography.typewriter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  color: color,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Cuadrícula de Parámetros de Campo
                  Text(
                    'PARÁMETROS FÍSICOS DE CAMPO',
                    style: PaperTypography.typewriter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: PaperColors.inkSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: PaperColors.paperBackgroundLight,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: PaperColors.cardBorderLight),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildParamItem('ESTATURA', '${pokemon.height / 10} m'),
                        Container(width: 1, height: 28, color: PaperColors.cardBorderLight),
                        _buildParamItem('MASA', '${pokemon.weight / 10} kg'),
                        Container(width: 1, height: 28, color: PaperColors.cardBorderLight),
                        _buildParamItem('LEGAJO', 'GEN ${pokemon.generationId}'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Nota de persistencia local
                  Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 14, color: PaperColors.stampGreen),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Espécimen registrado en el almacenamiento SQLite local.',
                          style: PaperTypography.typewriter(
                            fontSize: 10.5,
                            color: PaperColors.inkSecondaryLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildParamItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: PaperTypography.typewriter(
            fontSize: 9.5,
            fontWeight: FontWeight.bold,
            color: PaperColors.inkSecondaryLight,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: PaperTypography.typewriter(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: PaperColors.inkPrimaryLight,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeColor = AppColors.forType(pokemon.primaryType);
    final formattedName = pokemon.name.isNotEmpty
        ? '${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}'
        : '';

    return Semantics(
      label:
          'Ficha técnica ${pokemon.name}, número ${pokemon.id}, tipos ${pokemon.types.join(' y ')}${pokemon.isFavorite ? ', clasificado con clip de favorito' : ''}',
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showFieldDossierModal(context, ref),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            decoration: BoxDecoration(
              color: PaperColors.cardLight,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: PaperColors.cardBorderLight, width: 1.2),
              boxShadow: PaperColors.cardShadow,
            ),
            child: Stack(
              children: [
                // 1. Clip de latón colocado físicamente en la esquina superior derecha
                Positioned(
                  top: 0,
                  right: 8,
                  child: PaperclipWidget(
                    size: 24,
                    isFavorite: pokemon.isFavorite,
                    onTap: () => _onToggleFavorite(ref),
                  ),
                ),

                // 2. Contenido de la Ficha Técnica de Cartulina
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Número mecanografiado
                      Text(
                        _formatTypewriterNumber(pokemon.id),
                        style: PaperTypography.typewriter(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: PaperColors.inkSecondaryLight,
                          letterSpacing: 1.0,
                        ),
                      ),

                      const Spacer(),

                      // Ilustración central en risografía duotono
                      Center(
                        child: RisographArtwork(
                          imageUrl: pokemon.officialArtwork,
                          spriteUrl: pokemon.spriteUrl,
                          primaryTypeColor: typeColor,
                          size: 78,
                        ),
                      ),

                      const Spacer(),

                      // Nombre del espécimen
                      Text(
                        formattedName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: PaperTypography.naturalistTitle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: PaperColors.inkPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Sellos de tipo grabados
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: pokemon.types.map((type) {
                          final color = AppColors.forType(type);
                          final glyph = AppColors.glyphForType(type);
                          final code = AppColors.codeForType(type);
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.08),
                              border: Border.all(
                                color: color.withValues(alpha: 0.8),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  glyph,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  code,
                                  style: PaperTypography.typewriter(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w900,
                                    color: color,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
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
