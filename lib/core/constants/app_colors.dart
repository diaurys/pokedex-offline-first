import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Colores primarios y tema
  static const Color primaryRed = Color(0xFFE53935);
  static const Color darkRed = Color(0xFFC62828);
  static const Color pokeYellow = Color(0xFFFFCB05);
  static const Color pokeBlue = Color(0xFF2A75BB);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color lightBackground = Color(0xFFF7F9FC);
  static const Color lightSurface = Colors.white;

  // Estados de conectividad (IND-01 a IND-05)
  static const Color statusOnline = Color(0xFF2E7D32); // Verde
  static const Color statusOffline = Color(0xFFD32F2F); // Rojo
  static const Color statusServiceUnavailable = Color(0xFFF57C00); // Naranja
  static const Color statusSyncing = Color(0xFF1976D2); // Azul

  // Colores por tipo de Pokémon
  static const Map<String, Color> typeColors = {
    'normal': Color(0xFFA8A77A),
    'fire': Color(0xFFEE8130),
    'water': Color(0xFF6390F0),
    'electric': Color(0xFFF7D02C),
    'grass': Color(0xFF7AC74C),
    'ice': Color(0xFF96D9D6),
    'fighting': Color(0xFFC22E28),
    'poison': Color(0xFFA33EA1),
    'ground': Color(0xFFE2BF65),
    'flying': Color(0xFFA98FF3),
    'psychic': Color(0xFFF95587),
    'bug': Color(0xFFA6B91A),
    'rock': Color(0xFFB6A136),
    'ghost': Color(0xFF735797),
    'dragon': Color(0xFF6F35FC),
    'dark': Color(0xFF705746),
    'steel': Color(0xFFB7B7CE),
    'fairy': Color(0xFFD685AD),
  };

  static Color forType(String typeName) {
    return typeColors[typeName.toLowerCase()] ?? const Color(0xFF777777);
  }
}
