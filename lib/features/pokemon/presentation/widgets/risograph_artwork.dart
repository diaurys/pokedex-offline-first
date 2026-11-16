import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/paper_theme.dart';

/// Ilustración en Risografía Duotono (Tinta del Tipo + Azul Noche con Desalineado de Registro)
/// Metáfora: Grabado de imprenta artesanal de campo con 1.5 px de desajuste físico.
class RisographArtwork extends StatelessWidget {
  final String imageUrl;
  final String spriteUrl;
  final Color primaryTypeColor;
  final double size;

  const RisographArtwork({
    super.key,
    required this.imageUrl,
    required this.spriteUrl,
    required this.primaryTypeColor,
    this.size = 96.0,
  });

  Widget _buildFallbackAsset() {
    return Image.asset(
      'assets/images/pokeball_placeholder.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }

  Widget _buildImageStack(String targetUrl) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Capa 1: Desalineado de Tinta Azul Noche (Sombra de Registro 1.5px)
          Positioned(
            left: 1.5,
            top: 1.5,
            child: Opacity(
              opacity: 0.22,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  PaperColors.inkPrimaryLight, // Tinta Azul Noche
                  BlendMode.srcIn,
                ),
                child: CachedNetworkImage(
                  imageUrl: targetUrl,
                  width: size,
                  height: size,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => const SizedBox.shrink(),
                ),
              ),
            ),
          ),

          // Capa 2: Tinta de Pigmento Principal del Tipo
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              primaryTypeColor.withValues(alpha: 0.92),
              BlendMode.modulate,
            ),
            child: CachedNetworkImage(
              imageUrl: targetUrl,
              width: size,
              height: size,
              fit: BoxFit.contain,
              placeholder: (context, url) => Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      PaperColors.inkFaintLight,
                    ),
                  ),
                ),
              ),
              // Respaldo 1: Sprite si officialArtwork falla
              errorWidget: (context, url, error) {
                if (targetUrl != spriteUrl && spriteUrl.isNotEmpty) {
                  return _buildImageStack(spriteUrl);
                }
                // Respaldo 2: Asset local offline
                return _buildFallbackAsset();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty && spriteUrl.isEmpty) {
      return _buildFallbackAsset();
    }
    return _buildImageStack(imageUrl.isNotEmpty ? imageUrl : spriteUrl);
  }
}
