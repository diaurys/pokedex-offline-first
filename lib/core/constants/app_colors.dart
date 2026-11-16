import 'package:flutter/material.dart';
import '../theme/paper_theme.dart';

/// Paleta de colores globales armonizada con el concepto "Fichero Pokédex"
class AppColors {
  AppColors._();

  // Tonos de archivo y papel
  static const Color paperBackground = PaperColors.paperBackgroundLight;
  static const Color paperBackgroundDark = PaperColors.paperBackgroundDark;
  static const Color cardSurface = PaperColors.cardLight;
  static const Color cardSurfaceDark = PaperColors.cardDark;

  // Tintas
  static const Color inkPrimary = PaperColors.inkPrimaryLight;
  static const Color inkSecondary = PaperColors.inkSecondaryLight;
  static const Color inkFaint = PaperColors.inkFaintLight;

  // Metales
  static const Color brassClip = PaperColors.brassClip;

  // Estados de conectividad (IND-01 a IND-05) representados como tintas de sellos
  static const Color statusOnline = PaperColors.stampGreen;
  static const Color statusOffline = PaperColors.stampRed;
  static const Color statusServiceUnavailable = PaperColors.stampAmber;
  static const Color statusSyncing = PaperColors.stampBlue;

  // Compatibilidad con vistas heredadas
  static const Color primaryRed = PaperColors.stampRed;
  static const Color darkRed = Color(0xFF7E1C1C);
  static const Color lightBackground = PaperColors.paperBackgroundLight;
  static const Color lightSurface = PaperColors.cardLight;
  static const Color darkBackground = PaperColors.paperBackgroundDark;
  static const Color darkSurface = PaperColors.cardDark;

  // Mapa de colores pigmentarios por tipo de Pokémon
  static const Map<String, Color> typeColors = PaperColors.typePigments;

  static Color forType(String typeName) {
    return PaperColors.pigmentForType(typeName);
  }

  static String glyphForType(String typeName) {
    return PaperColors.glyphForType(typeName);
  }

  static String codeForType(String typeName) {
    return PaperColors.codeForType(typeName);
  }
}
