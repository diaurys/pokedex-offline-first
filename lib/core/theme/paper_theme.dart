import 'package:flutter/material.dart';

/// Design tokens y sistema visual del concepto "Fichero Pokédex"
/// Metáfora: Archivador de papel, fichas de cartulina, risografía duotono y sellos de goma.
class PaperColors {
  PaperColors._();

  // Sustratos neutros
  static const Color paperBackgroundLight = Color(0xFFF5EEDB); // Crema natural
  static const Color paperBackgroundDark = Color(0xFF181716);  // Papel carbón
  static const Color cardLight = Color(0xFFFCF8EC);            // Cartulina manila
  static const Color cardDark = Color(0xFF22201E);             // Cartulina oscura
  static const Color cardBorderLight = Color(0xFFE5DCBE);
  static const Color cardBorderDark = Color(0xFF33302B);

  // Tintas de imprenta
  static const Color inkPrimaryLight = Color(0xFF141C2B);      // Azul noche profundo
  static const Color inkPrimaryDark = Color(0xFFEDE6D6);       // Tinta hueso
  static const Color inkSecondaryLight = Color(0xFF4B5361);    // Grafito natural
  static const Color inkSecondaryDark = Color(0xFFA6A092);     // Grafito claro
  static const Color inkFaintLight = Color(0xFFD6CDB8);        // Líneas de pauta
  static const Color inkFaintDark = Color(0xFF3A3733);

  // Metales y sellos
  static const Color brassClip = Color(0xFFB08D57);            // Latón envejecido
  static const Color brassClipDark = Color(0xFFC4A675);
  static const Color stampRed = Color(0xFFA82828);             // Lacre rojo / Offline
  static const Color stampGreen = Color(0xFF20663B);           // Botánica / Online
  static const Color stampBlue = Color(0xFF1B4F8A);            // Registro / Sync
  static const Color stampAmber = Color(0xFFA86600);           // Alerta / No disponible

  // Sombras físicas de papel (doble capa sutil, no difusa moderna)
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x1F2A2118),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Color(0x142A2118),
      offset: Offset(0, 3),
      blurRadius: 5,
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> clipShadow = [
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(1, 1),
      blurRadius: 2,
    ),
  ];

  // Paleta de pigmentos Risográficos para los 18 tipos (Contraste verificado)
  static const Map<String, Color> typePigments = {
    'normal': Color(0xFF666355),
    'fire': Color(0xFFBA3416),
    'water': Color(0xFF1A5296),
    'grass': Color(0xFF27662B),
    'electric': Color(0xFF8F6000),
    'ice': Color(0xFF16687A),
    'fighting': Color(0xFF8A1E19),
    'poison': Color(0xFF69296B),
    'ground': Color(0xFF7D521B),
    'flying': Color(0xFF3D4387),
    'psychic': Color(0xFFA11950),
    'bug': Color(0xFF526315),
    'rock': Color(0xFF6E5D20),
    'ghost': Color(0xFF453363),
    'dragon': Color(0xFF361F8F),
    'dark': Color(0xFF332922),
    'steel': Color(0xFF444F5E),
    'fairy': Color(0xFF94275C),
  };

  // Glifos grabados geométricos para cada tipo
  static const Map<String, String> typeGlyphs = {
    'normal': '◎',
    'fire': '▲',
    'water': '▽',
    'grass': '◇',
    'electric': '⌁',
    'ice': '✶',
    'fighting': '☒',
    'poison': '◈',
    'ground': '⏢',
    'flying': '︾',
    'psychic': '◉',
    'bug': '⚯',
    'rock': '⬢',
    'ghost': '◚',
    'dragon': '⌬',
    'dark': '☽',
    'steel': '⬡',
    'fairy': '✧',
  };

  // Código estampado de 3 letras
  static const Map<String, String> typeCodes = {
    'normal': 'NOR',
    'fire': 'FUE',
    'water': 'AGU',
    'grass': 'PLA',
    'electric': 'ELE',
    'ice': 'HIE',
    'fighting': 'LUC',
    'poison': 'VEN',
    'ground': 'TIE',
    'flying': 'VOL',
    'psychic': 'PSI',
    'bug': 'BIC',
    'rock': 'ROC',
    'ghost': 'FAN',
    'dragon': 'DRA',
    'dark': 'SIN',
    'steel': 'ACE',
    'fairy': 'HAD',
  };

  static Color pigmentForType(String type) {
    return typePigments[type.toLowerCase()] ?? const Color(0xFF666355);
  }

  static String glyphForType(String type) {
    return typeGlyphs[type.toLowerCase()] ?? '•';
  }

  static String codeForType(String type) {
    return typeCodes[type.toLowerCase()] ?? type.toUpperCase();
  }
}

/// Estilos tipográficos analógicos (Typewriter mono + Naturalist serif)
class PaperTypography {
  PaperTypography._();

  static const List<String> typewriterFallbacks = [
    'Courier New',
    'Courier',
    'Lucida Console',
    'monospace',
  ];

  static const List<String> serifFallbacks = [
    'Georgia',
    'Palatino',
    'Times New Roman',
    'serif',
  ];

  static TextStyle typewriter({
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamilyFallback: typewriterFallbacks,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing ?? 1.2,
    );
  }

  static TextStyle naturalistTitle({
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.bold,
    Color? color,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamilyFallback: serifFallbacks,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }
}

/// ThemeExtension de Flutter para soporte completo de tema claro y oscuro
@immutable
class PaperThemeExtension extends ThemeExtension<PaperThemeExtension> {
  final Color paperBackground;
  final Color cardBackground;
  final Color cardBorder;
  final Color inkPrimary;
  final Color inkSecondary;
  final Color inkFaint;
  final Color brassClip;
  final Color stampRed;
  final Color stampGreen;
  final Color stampBlue;
  final Color stampAmber;

  const PaperThemeExtension({
    required this.paperBackground,
    required this.cardBackground,
    required this.cardBorder,
    required this.inkPrimary,
    required this.inkSecondary,
    required this.inkFaint,
    required this.brassClip,
    required this.stampRed,
    required this.stampGreen,
    required this.stampBlue,
    required this.stampAmber,
  });

  static const light = PaperThemeExtension(
    paperBackground: PaperColors.paperBackgroundLight,
    cardBackground: PaperColors.cardLight,
    cardBorder: PaperColors.cardBorderLight,
    inkPrimary: PaperColors.inkPrimaryLight,
    inkSecondary: PaperColors.inkSecondaryLight,
    inkFaint: PaperColors.inkFaintLight,
    brassClip: PaperColors.brassClip,
    stampRed: PaperColors.stampRed,
    stampGreen: PaperColors.stampGreen,
    stampBlue: PaperColors.stampBlue,
    stampAmber: PaperColors.stampAmber,
  );

  static const dark = PaperThemeExtension(
    paperBackground: PaperColors.paperBackgroundDark,
    cardBackground: PaperColors.cardDark,
    cardBorder: PaperColors.cardBorderDark,
    inkPrimary: PaperColors.inkPrimaryDark,
    inkSecondary: PaperColors.inkSecondaryDark,
    inkFaint: PaperColors.inkFaintDark,
    brassClip: PaperColors.brassClipDark,
    stampRed: Color(0xFFE05A5A),
    stampGreen: Color(0xFF4CAF70),
    stampBlue: Color(0xFF5C9CE6),
    stampAmber: Color(0xFFFFA726),
  );

  @override
  ThemeExtension<PaperThemeExtension> copyWith({
    Color? paperBackground,
    Color? cardBackground,
    Color? cardBorder,
    Color? inkPrimary,
    Color? inkSecondary,
    Color? inkFaint,
    Color? brassClip,
    Color? stampRed,
    Color? stampGreen,
    Color? stampBlue,
    Color? stampAmber,
  }) {
    return PaperThemeExtension(
      paperBackground: paperBackground ?? this.paperBackground,
      cardBackground: cardBackground ?? this.cardBackground,
      cardBorder: cardBorder ?? this.cardBorder,
      inkPrimary: inkPrimary ?? this.inkPrimary,
      inkSecondary: inkSecondary ?? this.inkSecondary,
      inkFaint: inkFaint ?? this.inkFaint,
      brassClip: brassClip ?? this.brassClip,
      stampRed: stampRed ?? this.stampRed,
      stampGreen: stampGreen ?? this.stampGreen,
      stampBlue: stampBlue ?? this.stampBlue,
      stampAmber: stampAmber ?? this.stampAmber,
    );
  }

  @override
  ThemeExtension<PaperThemeExtension> lerp(
    ThemeExtension<PaperThemeExtension>? other,
    double t,
  ) {
    if (other is! PaperThemeExtension) return this;
    return PaperThemeExtension(
      paperBackground: Color.lerp(paperBackground, other.paperBackground, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      inkPrimary: Color.lerp(inkPrimary, other.inkPrimary, t)!,
      inkSecondary: Color.lerp(inkSecondary, other.inkSecondary, t)!,
      inkFaint: Color.lerp(inkFaint, other.inkFaint, t)!,
      brassClip: Color.lerp(brassClip, other.brassClip, t)!,
      stampRed: Color.lerp(stampRed, other.stampRed, t)!,
      stampGreen: Color.lerp(stampGreen, other.stampGreen, t)!,
      stampBlue: Color.lerp(stampBlue, other.stampBlue, t)!,
      stampAmber: Color.lerp(stampAmber, other.stampAmber, t)!,
    );
  }
}
