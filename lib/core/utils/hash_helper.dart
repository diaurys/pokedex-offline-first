import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashHelper {
  HashHelper._();

  /// Genera un hash SHA-256 consistente de los atributos del catálogo (OF-19, PA-16)
  static String calculatePokemonHash({
    required int id,
    required String name,
    required int height,
    required int weight,
    required List<String> types,
  }) {
    final sortedTypes = List<String>.from(types)..sort();
    final rawData = '$id|${name.trim().toLowerCase()}|$height|$weight|${sortedTypes.join(',')}';
    return sha256.convert(utf8.encode(rawData)).toString();
  }
}
