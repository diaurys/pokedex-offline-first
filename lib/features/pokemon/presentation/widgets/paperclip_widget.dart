import 'package:flutter/material.dart';
import '../../../../core/theme/paper_theme.dart';

/// Widget de Clip de Latón para Marcar Fichas Favoritas
/// Metáfora: Un clip metálico vintage enganchado físicamente en la esquina de la ficha de cartulina.
class PaperclipWidget extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;
  final double size;

  const PaperclipWidget({
    super.key,
    required this.isFavorite,
    required this.onTap,
    this.size = 28.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Tooltip(
        message: isFavorite
            ? 'Retirar clip (Quitar de favoritos)'
            : 'Enganchar clip (Marcar favorito)',
        child: SizedBox(
          width: size,
          height: size * 1.5,
          child: CustomPaint(
            painter: _BrassClipPainter(isFavorite: isFavorite),
          ),
        ),
      ),
    );
  }
}

class _BrassClipPainter extends CustomPainter {
  final bool isFavorite;

  const _BrassClipPainter({required this.isFavorite});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final baseColor = isFavorite
        ? PaperColors.brassClip
        : PaperColors.inkFaintLight.withValues(alpha: 0.6);

    // Sombra del clip sobre el papel si está activo
    if (isFavorite) {
      final shadowPaint = Paint()
        ..color = const Color(0x33141C2B)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.2);

      final shadowPath = Path();
      _drawClipShape(shadowPath, w, h, dx: 1.2, dy: 1.5);
      canvas.drawPath(shadowPath, shadowPaint);
    }

    // Trazo principal del clip de latón
    final clipPaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = isFavorite ? 2.5 : 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final clipPath = Path();
    _drawClipShape(clipPath, w, h);
    canvas.drawPath(clipPath, clipPaint);

    // Brillo metálico superior si está activo
    if (isFavorite) {
      final highlightPaint = Paint()
        ..color = const Color(0xFFF0D68A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..strokeCap = StrokeCap.round;

      final highlightPath = Path()
        ..moveTo(w * 0.35, h * 0.25)
        ..lineTo(w * 0.35, h * 0.7);
      canvas.drawPath(highlightPath, highlightPaint);
    }
  }

  void _drawClipShape(Path path, double w, double h, {double dx = 0, double dy = 0}) {
    // Geometría física de un clip sujetapapeles estándar:
    // Empieza en la pata interior, gira arriba, baja, gira abajo y sube la pata exterior
    path.moveTo(w * 0.55 + dx, h * 0.75 + dy);
    path.lineTo(w * 0.55 + dx, h * 0.28 + dy);
    path.arcToPoint(
      Offset(w * 0.35 + dx, h * 0.28 + dy),
      radius: Radius.circular(w * 0.1),
      clockwise: false,
    );
    path.lineTo(w * 0.35 + dx, h * 0.82 + dy);
    path.arcToPoint(
      Offset(w * 0.8 + dx, h * 0.82 + dy),
      radius: Radius.circular(w * 0.22),
      clockwise: false,
    );
    path.lineTo(w * 0.8 + dx, h * 0.15 + dy);
    path.arcToPoint(
      Offset(w * 0.15 + dx, h * 0.15 + dy),
      radius: Radius.circular(w * 0.32),
      clockwise: false,
    );
    path.lineTo(w * 0.15 + dx, h * 0.65 + dy);
  }

  @override
  bool shouldRepaint(covariant _BrassClipPainter oldDelegate) {
    return oldDelegate.isFavorite != isFavorite;
  }
}
