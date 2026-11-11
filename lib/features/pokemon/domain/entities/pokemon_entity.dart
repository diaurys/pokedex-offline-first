import '../../../../core/constants/api_constants.dart';

class PokemonTypeEntity {
  final int id;
  final String name;
  final int slot;

  const PokemonTypeEntity({
    required this.id,
    required this.name,
    required this.slot,
  });
}

class PokemonStatEntity {
  final String name;
  final int value;

  const PokemonStatEntity({
    required this.name,
    required this.value,
  });

  String get displayName {
    switch (name.toLowerCase()) {
      case 'hp':
        return 'PS';
      case 'attack':
        return 'Ataque';
      case 'defense':
        return 'Defensa';
      case 'special-attack':
        return 'Atq. Esp.';
      case 'special-defense':
        return 'Def. Esp.';
      case 'speed':
        return 'Velocidad';
      default:
        return name;
    }
  }
}

class PokemonAbilityEntity {
  final String name;
  final bool isHidden;
  final String? shortEffect;

  const PokemonAbilityEntity({
    required this.name,
    required this.isHidden,
    this.shortEffect,
  });
}

class PokemonMoveEntity {
  final int id;
  final String name;
  final String typeName;
  final int? power;
  final int? accuracy;
  final int? pp;
  final int level;
  final String learnMethod;

  const PokemonMoveEntity({
    required this.id,
    required this.name,
    required this.typeName,
    this.power,
    this.accuracy,
    this.pp,
    this.level = 0,
    this.learnMethod = 'level-up',
  });
}

class PokemonEvolutionEntity {
  final int speciesId;
  final String speciesName;
  final int? evolvesFromId;
  final String? triggerName;
  final int? minLevel;

  const PokemonEvolutionEntity({
    required this.speciesId,
    required this.speciesName,
    this.evolvesFromId,
    this.triggerName,
    this.minLevel,
  });

  String get imageUrl => ApiConstants.officialArtworkUrl(speciesId);
}

/// Entidad resumida para el Catálogo y listas (RF-CAT-01)
class PokemonListItem {
  final int id;
  final String name;
  final int height;
  final int weight;
  final int generationId;
  final List<String> types;
  final bool isFavorite;
  final int? baseExperience;
  final int totalBaseStats;

  const PokemonListItem({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.generationId,
    required this.types,
    this.isFavorite = false,
    this.baseExperience,
    this.totalBaseStats = 0,
  });

  String get formattedNumber => '#${id.toString().padLeft(3, '0')}';
  String get officialArtwork => ApiConstants.officialArtworkUrl(id);
  String get officialArtworkShiny => ApiConstants.officialArtworkShinyUrl(id);
  String get spriteUrl => ApiConstants.spriteFallbackUrl(id);
  String get spriteShinyUrl => ApiConstants.spriteShinyFallbackUrl(id);
  String get primaryType => types.isNotEmpty ? types.first : 'normal';
}

/// Entidad completa para la pantalla de Detalle (RF-DET)
class PokemonDetail {
  final int id;
  final String name;
  final int height;
  final int weight;
  final int? baseExperience;
  final int generationId;
  final String? flavorText;
  final String? speciesGenus;
  final int? evolutionChainId;
  final List<PokemonTypeEntity> types;
  final List<PokemonStatEntity> stats;
  final List<PokemonAbilityEntity> abilities;
  final List<PokemonMoveEntity> moves;
  final List<PokemonEvolutionEntity> evolutions;
  final bool isFavorite;
  final bool isTampered;

  const PokemonDetail({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    this.baseExperience,
    required this.generationId,
    this.flavorText,
    this.speciesGenus,
    this.evolutionChainId,
    required this.types,
    required this.stats,
    required this.abilities,
    required this.moves,
    required this.evolutions,
    this.isFavorite = false,
    this.isTampered = false,
  });

  String get formattedNumber => '#${id.toString().padLeft(3, '0')}';
  String get officialArtwork => ApiConstants.officialArtworkUrl(id);
  String get officialArtworkShiny => ApiConstants.officialArtworkShinyUrl(id);
  String get spriteUrl => ApiConstants.spriteFallbackUrl(id);
  String get spriteShinyUrl => ApiConstants.spriteShinyFallbackUrl(id);

  /// Altura en metros (de decímetros de PokeAPI)
  double get heightMeters => height / 10.0;

  /// Peso en kilogramos (de hectogramos de PokeAPI)
  double get weightKg => weight / 10.0;

  int get totalBaseStats => stats.fold(0, (sum, stat) => sum + stat.value);

  String get primaryType => types.isNotEmpty ? types.first.name : 'normal';
}
