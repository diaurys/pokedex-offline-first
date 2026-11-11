// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PokemonsTable extends Pokemons with TableInfo<$PokemonsTable, Pokemon> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseExperienceMeta = const VerificationMeta(
    'baseExperience',
  );
  @override
  late final GeneratedColumn<int> baseExperience = GeneratedColumn<int>(
    'base_experience',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _generationIdMeta = const VerificationMeta(
    'generationId',
  );
  @override
  late final GeneratedColumn<int> generationId = GeneratedColumn<int>(
    'generation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _flavorTextMeta = const VerificationMeta(
    'flavorText',
  );
  @override
  late final GeneratedColumn<String> flavorText = GeneratedColumn<String>(
    'flavor_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speciesGenusMeta = const VerificationMeta(
    'speciesGenus',
  );
  @override
  late final GeneratedColumn<String> speciesGenus = GeneratedColumn<String>(
    'species_genus',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _evolutionChainIdMeta = const VerificationMeta(
    'evolutionChainId',
  );
  @override
  late final GeneratedColumn<int> evolutionChainId = GeneratedColumn<int>(
    'evolution_chain_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    height,
    weight,
    baseExperience,
    generationId,
    flavorText,
    speciesGenus,
    evolutionChainId,
    contentHash,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemons';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pokemon> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('base_experience')) {
      context.handle(
        _baseExperienceMeta,
        baseExperience.isAcceptableOrUnknown(
          data['base_experience']!,
          _baseExperienceMeta,
        ),
      );
    }
    if (data.containsKey('generation_id')) {
      context.handle(
        _generationIdMeta,
        generationId.isAcceptableOrUnknown(
          data['generation_id']!,
          _generationIdMeta,
        ),
      );
    }
    if (data.containsKey('flavor_text')) {
      context.handle(
        _flavorTextMeta,
        flavorText.isAcceptableOrUnknown(data['flavor_text']!, _flavorTextMeta),
      );
    }
    if (data.containsKey('species_genus')) {
      context.handle(
        _speciesGenusMeta,
        speciesGenus.isAcceptableOrUnknown(
          data['species_genus']!,
          _speciesGenusMeta,
        ),
      );
    }
    if (data.containsKey('evolution_chain_id')) {
      context.handle(
        _evolutionChainIdMeta,
        evolutionChainId.isAcceptableOrUnknown(
          data['evolution_chain_id']!,
          _evolutionChainIdMeta,
        ),
      );
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pokemon map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pokemon(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      )!,
      baseExperience: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_experience'],
      ),
      generationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation_id'],
      )!,
      flavorText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavor_text'],
      ),
      speciesGenus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species_genus'],
      ),
      evolutionChainId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}evolution_chain_id'],
      ),
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PokemonsTable createAlias(String alias) {
    return $PokemonsTable(attachedDatabase, alias);
  }
}

class Pokemon extends DataClass implements Insertable<Pokemon> {
  final int id;
  final String name;
  final int height;
  final int weight;
  final int? baseExperience;
  final int generationId;
  final String? flavorText;
  final String? speciesGenus;
  final int? evolutionChainId;
  final String? contentHash;
  final DateTime updatedAt;
  const Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    this.baseExperience,
    required this.generationId,
    this.flavorText,
    this.speciesGenus,
    this.evolutionChainId,
    this.contentHash,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['height'] = Variable<int>(height);
    map['weight'] = Variable<int>(weight);
    if (!nullToAbsent || baseExperience != null) {
      map['base_experience'] = Variable<int>(baseExperience);
    }
    map['generation_id'] = Variable<int>(generationId);
    if (!nullToAbsent || flavorText != null) {
      map['flavor_text'] = Variable<String>(flavorText);
    }
    if (!nullToAbsent || speciesGenus != null) {
      map['species_genus'] = Variable<String>(speciesGenus);
    }
    if (!nullToAbsent || evolutionChainId != null) {
      map['evolution_chain_id'] = Variable<int>(evolutionChainId);
    }
    if (!nullToAbsent || contentHash != null) {
      map['content_hash'] = Variable<String>(contentHash);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PokemonsCompanion toCompanion(bool nullToAbsent) {
    return PokemonsCompanion(
      id: Value(id),
      name: Value(name),
      height: Value(height),
      weight: Value(weight),
      baseExperience: baseExperience == null && nullToAbsent
          ? const Value.absent()
          : Value(baseExperience),
      generationId: Value(generationId),
      flavorText: flavorText == null && nullToAbsent
          ? const Value.absent()
          : Value(flavorText),
      speciesGenus: speciesGenus == null && nullToAbsent
          ? const Value.absent()
          : Value(speciesGenus),
      evolutionChainId: evolutionChainId == null && nullToAbsent
          ? const Value.absent()
          : Value(evolutionChainId),
      contentHash: contentHash == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHash),
      updatedAt: Value(updatedAt),
    );
  }

  factory Pokemon.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pokemon(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      height: serializer.fromJson<int>(json['height']),
      weight: serializer.fromJson<int>(json['weight']),
      baseExperience: serializer.fromJson<int?>(json['baseExperience']),
      generationId: serializer.fromJson<int>(json['generationId']),
      flavorText: serializer.fromJson<String?>(json['flavorText']),
      speciesGenus: serializer.fromJson<String?>(json['speciesGenus']),
      evolutionChainId: serializer.fromJson<int?>(json['evolutionChainId']),
      contentHash: serializer.fromJson<String?>(json['contentHash']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'height': serializer.toJson<int>(height),
      'weight': serializer.toJson<int>(weight),
      'baseExperience': serializer.toJson<int?>(baseExperience),
      'generationId': serializer.toJson<int>(generationId),
      'flavorText': serializer.toJson<String?>(flavorText),
      'speciesGenus': serializer.toJson<String?>(speciesGenus),
      'evolutionChainId': serializer.toJson<int?>(evolutionChainId),
      'contentHash': serializer.toJson<String?>(contentHash),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Pokemon copyWith({
    int? id,
    String? name,
    int? height,
    int? weight,
    Value<int?> baseExperience = const Value.absent(),
    int? generationId,
    Value<String?> flavorText = const Value.absent(),
    Value<String?> speciesGenus = const Value.absent(),
    Value<int?> evolutionChainId = const Value.absent(),
    Value<String?> contentHash = const Value.absent(),
    DateTime? updatedAt,
  }) => Pokemon(
    id: id ?? this.id,
    name: name ?? this.name,
    height: height ?? this.height,
    weight: weight ?? this.weight,
    baseExperience: baseExperience.present
        ? baseExperience.value
        : this.baseExperience,
    generationId: generationId ?? this.generationId,
    flavorText: flavorText.present ? flavorText.value : this.flavorText,
    speciesGenus: speciesGenus.present ? speciesGenus.value : this.speciesGenus,
    evolutionChainId: evolutionChainId.present
        ? evolutionChainId.value
        : this.evolutionChainId,
    contentHash: contentHash.present ? contentHash.value : this.contentHash,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Pokemon copyWithCompanion(PokemonsCompanion data) {
    return Pokemon(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
      baseExperience: data.baseExperience.present
          ? data.baseExperience.value
          : this.baseExperience,
      generationId: data.generationId.present
          ? data.generationId.value
          : this.generationId,
      flavorText: data.flavorText.present
          ? data.flavorText.value
          : this.flavorText,
      speciesGenus: data.speciesGenus.present
          ? data.speciesGenus.value
          : this.speciesGenus,
      evolutionChainId: data.evolutionChainId.present
          ? data.evolutionChainId.value
          : this.evolutionChainId,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pokemon(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('baseExperience: $baseExperience, ')
          ..write('generationId: $generationId, ')
          ..write('flavorText: $flavorText, ')
          ..write('speciesGenus: $speciesGenus, ')
          ..write('evolutionChainId: $evolutionChainId, ')
          ..write('contentHash: $contentHash, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    height,
    weight,
    baseExperience,
    generationId,
    flavorText,
    speciesGenus,
    evolutionChainId,
    contentHash,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pokemon &&
          other.id == this.id &&
          other.name == this.name &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.baseExperience == this.baseExperience &&
          other.generationId == this.generationId &&
          other.flavorText == this.flavorText &&
          other.speciesGenus == this.speciesGenus &&
          other.evolutionChainId == this.evolutionChainId &&
          other.contentHash == this.contentHash &&
          other.updatedAt == this.updatedAt);
}

class PokemonsCompanion extends UpdateCompanion<Pokemon> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> height;
  final Value<int> weight;
  final Value<int?> baseExperience;
  final Value<int> generationId;
  final Value<String?> flavorText;
  final Value<String?> speciesGenus;
  final Value<int?> evolutionChainId;
  final Value<String?> contentHash;
  final Value<DateTime> updatedAt;
  const PokemonsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.baseExperience = const Value.absent(),
    this.generationId = const Value.absent(),
    this.flavorText = const Value.absent(),
    this.speciesGenus = const Value.absent(),
    this.evolutionChainId = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PokemonsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int height,
    required int weight,
    this.baseExperience = const Value.absent(),
    this.generationId = const Value.absent(),
    this.flavorText = const Value.absent(),
    this.speciesGenus = const Value.absent(),
    this.evolutionChainId = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       height = Value(height),
       weight = Value(weight);
  static Insertable<Pokemon> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? height,
    Expression<int>? weight,
    Expression<int>? baseExperience,
    Expression<int>? generationId,
    Expression<String>? flavorText,
    Expression<String>? speciesGenus,
    Expression<int>? evolutionChainId,
    Expression<String>? contentHash,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (baseExperience != null) 'base_experience': baseExperience,
      if (generationId != null) 'generation_id': generationId,
      if (flavorText != null) 'flavor_text': flavorText,
      if (speciesGenus != null) 'species_genus': speciesGenus,
      if (evolutionChainId != null) 'evolution_chain_id': evolutionChainId,
      if (contentHash != null) 'content_hash': contentHash,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PokemonsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? height,
    Value<int>? weight,
    Value<int?>? baseExperience,
    Value<int>? generationId,
    Value<String?>? flavorText,
    Value<String?>? speciesGenus,
    Value<int?>? evolutionChainId,
    Value<String?>? contentHash,
    Value<DateTime>? updatedAt,
  }) {
    return PokemonsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      baseExperience: baseExperience ?? this.baseExperience,
      generationId: generationId ?? this.generationId,
      flavorText: flavorText ?? this.flavorText,
      speciesGenus: speciesGenus ?? this.speciesGenus,
      evolutionChainId: evolutionChainId ?? this.evolutionChainId,
      contentHash: contentHash ?? this.contentHash,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (baseExperience.present) {
      map['base_experience'] = Variable<int>(baseExperience.value);
    }
    if (generationId.present) {
      map['generation_id'] = Variable<int>(generationId.value);
    }
    if (flavorText.present) {
      map['flavor_text'] = Variable<String>(flavorText.value);
    }
    if (speciesGenus.present) {
      map['species_genus'] = Variable<String>(speciesGenus.value);
    }
    if (evolutionChainId.present) {
      map['evolution_chain_id'] = Variable<int>(evolutionChainId.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('baseExperience: $baseExperience, ')
          ..write('generationId: $generationId, ')
          ..write('flavorText: $flavorText, ')
          ..write('speciesGenus: $speciesGenus, ')
          ..write('evolutionChainId: $evolutionChainId, ')
          ..write('contentHash: $contentHash, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PokemonTypesTable extends PokemonTypes
    with TableInfo<$PokemonTypesTable, PokemonType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemons (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeNameMeta = const VerificationMeta(
    'typeName',
  );
  @override
  late final GeneratedColumn<String> typeName = GeneratedColumn<String>(
    'type_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, pokemonId, slot, typeName, typeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    if (data.containsKey('type_name')) {
      context.handle(
        _typeNameMeta,
        typeName.isAcceptableOrUnknown(data['type_name']!, _typeNameMeta),
      );
    } else if (isInserting) {
      context.missing(_typeNameMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
      typeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_name'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
    );
  }

  @override
  $PokemonTypesTable createAlias(String alias) {
    return $PokemonTypesTable(attachedDatabase, alias);
  }
}

class PokemonType extends DataClass implements Insertable<PokemonType> {
  final int id;
  final int pokemonId;
  final int slot;
  final String typeName;
  final int typeId;
  const PokemonType({
    required this.id,
    required this.pokemonId,
    required this.slot,
    required this.typeName,
    required this.typeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['slot'] = Variable<int>(slot);
    map['type_name'] = Variable<String>(typeName);
    map['type_id'] = Variable<int>(typeId);
    return map;
  }

  PokemonTypesCompanion toCompanion(bool nullToAbsent) {
    return PokemonTypesCompanion(
      id: Value(id),
      pokemonId: Value(pokemonId),
      slot: Value(slot),
      typeName: Value(typeName),
      typeId: Value(typeId),
    );
  }

  factory PokemonType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonType(
      id: serializer.fromJson<int>(json['id']),
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      slot: serializer.fromJson<int>(json['slot']),
      typeName: serializer.fromJson<String>(json['typeName']),
      typeId: serializer.fromJson<int>(json['typeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pokemonId': serializer.toJson<int>(pokemonId),
      'slot': serializer.toJson<int>(slot),
      'typeName': serializer.toJson<String>(typeName),
      'typeId': serializer.toJson<int>(typeId),
    };
  }

  PokemonType copyWith({
    int? id,
    int? pokemonId,
    int? slot,
    String? typeName,
    int? typeId,
  }) => PokemonType(
    id: id ?? this.id,
    pokemonId: pokemonId ?? this.pokemonId,
    slot: slot ?? this.slot,
    typeName: typeName ?? this.typeName,
    typeId: typeId ?? this.typeId,
  );
  PokemonType copyWithCompanion(PokemonTypesCompanion data) {
    return PokemonType(
      id: data.id.present ? data.id.value : this.id,
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      slot: data.slot.present ? data.slot.value : this.slot,
      typeName: data.typeName.present ? data.typeName.value : this.typeName,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonType(')
          ..write('id: $id, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('slot: $slot, ')
          ..write('typeName: $typeName, ')
          ..write('typeId: $typeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pokemonId, slot, typeName, typeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonType &&
          other.id == this.id &&
          other.pokemonId == this.pokemonId &&
          other.slot == this.slot &&
          other.typeName == this.typeName &&
          other.typeId == this.typeId);
}

class PokemonTypesCompanion extends UpdateCompanion<PokemonType> {
  final Value<int> id;
  final Value<int> pokemonId;
  final Value<int> slot;
  final Value<String> typeName;
  final Value<int> typeId;
  const PokemonTypesCompanion({
    this.id = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.slot = const Value.absent(),
    this.typeName = const Value.absent(),
    this.typeId = const Value.absent(),
  });
  PokemonTypesCompanion.insert({
    this.id = const Value.absent(),
    required int pokemonId,
    required int slot,
    required String typeName,
    required int typeId,
  }) : pokemonId = Value(pokemonId),
       slot = Value(slot),
       typeName = Value(typeName),
       typeId = Value(typeId);
  static Insertable<PokemonType> custom({
    Expression<int>? id,
    Expression<int>? pokemonId,
    Expression<int>? slot,
    Expression<String>? typeName,
    Expression<int>? typeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (slot != null) 'slot': slot,
      if (typeName != null) 'type_name': typeName,
      if (typeId != null) 'type_id': typeId,
    });
  }

  PokemonTypesCompanion copyWith({
    Value<int>? id,
    Value<int>? pokemonId,
    Value<int>? slot,
    Value<String>? typeName,
    Value<int>? typeId,
  }) {
    return PokemonTypesCompanion(
      id: id ?? this.id,
      pokemonId: pokemonId ?? this.pokemonId,
      slot: slot ?? this.slot,
      typeName: typeName ?? this.typeName,
      typeId: typeId ?? this.typeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (typeName.present) {
      map['type_name'] = Variable<String>(typeName.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypesCompanion(')
          ..write('id: $id, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('slot: $slot, ')
          ..write('typeName: $typeName, ')
          ..write('typeId: $typeId')
          ..write(')'))
        .toString();
  }
}

class $PokemonStatsTable extends PokemonStats
    with TableInfo<$PokemonStatsTable, PokemonStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemons (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _statNameMeta = const VerificationMeta(
    'statName',
  );
  @override
  late final GeneratedColumn<String> statName = GeneratedColumn<String>(
    'stat_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseStatMeta = const VerificationMeta(
    'baseStat',
  );
  @override
  late final GeneratedColumn<int> baseStat = GeneratedColumn<int>(
    'base_stat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, pokemonId, statName, baseStat];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonStat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('stat_name')) {
      context.handle(
        _statNameMeta,
        statName.isAcceptableOrUnknown(data['stat_name']!, _statNameMeta),
      );
    } else if (isInserting) {
      context.missing(_statNameMeta);
    }
    if (data.containsKey('base_stat')) {
      context.handle(
        _baseStatMeta,
        baseStat.isAcceptableOrUnknown(data['base_stat']!, _baseStatMeta),
      );
    } else if (isInserting) {
      context.missing(_baseStatMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonStat(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      statName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stat_name'],
      )!,
      baseStat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_stat'],
      )!,
    );
  }

  @override
  $PokemonStatsTable createAlias(String alias) {
    return $PokemonStatsTable(attachedDatabase, alias);
  }
}

class PokemonStat extends DataClass implements Insertable<PokemonStat> {
  final int id;
  final int pokemonId;
  final String statName;
  final int baseStat;
  const PokemonStat({
    required this.id,
    required this.pokemonId,
    required this.statName,
    required this.baseStat,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['stat_name'] = Variable<String>(statName);
    map['base_stat'] = Variable<int>(baseStat);
    return map;
  }

  PokemonStatsCompanion toCompanion(bool nullToAbsent) {
    return PokemonStatsCompanion(
      id: Value(id),
      pokemonId: Value(pokemonId),
      statName: Value(statName),
      baseStat: Value(baseStat),
    );
  }

  factory PokemonStat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonStat(
      id: serializer.fromJson<int>(json['id']),
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      statName: serializer.fromJson<String>(json['statName']),
      baseStat: serializer.fromJson<int>(json['baseStat']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pokemonId': serializer.toJson<int>(pokemonId),
      'statName': serializer.toJson<String>(statName),
      'baseStat': serializer.toJson<int>(baseStat),
    };
  }

  PokemonStat copyWith({
    int? id,
    int? pokemonId,
    String? statName,
    int? baseStat,
  }) => PokemonStat(
    id: id ?? this.id,
    pokemonId: pokemonId ?? this.pokemonId,
    statName: statName ?? this.statName,
    baseStat: baseStat ?? this.baseStat,
  );
  PokemonStat copyWithCompanion(PokemonStatsCompanion data) {
    return PokemonStat(
      id: data.id.present ? data.id.value : this.id,
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      statName: data.statName.present ? data.statName.value : this.statName,
      baseStat: data.baseStat.present ? data.baseStat.value : this.baseStat,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonStat(')
          ..write('id: $id, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('statName: $statName, ')
          ..write('baseStat: $baseStat')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pokemonId, statName, baseStat);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonStat &&
          other.id == this.id &&
          other.pokemonId == this.pokemonId &&
          other.statName == this.statName &&
          other.baseStat == this.baseStat);
}

class PokemonStatsCompanion extends UpdateCompanion<PokemonStat> {
  final Value<int> id;
  final Value<int> pokemonId;
  final Value<String> statName;
  final Value<int> baseStat;
  const PokemonStatsCompanion({
    this.id = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.statName = const Value.absent(),
    this.baseStat = const Value.absent(),
  });
  PokemonStatsCompanion.insert({
    this.id = const Value.absent(),
    required int pokemonId,
    required String statName,
    required int baseStat,
  }) : pokemonId = Value(pokemonId),
       statName = Value(statName),
       baseStat = Value(baseStat);
  static Insertable<PokemonStat> custom({
    Expression<int>? id,
    Expression<int>? pokemonId,
    Expression<String>? statName,
    Expression<int>? baseStat,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (statName != null) 'stat_name': statName,
      if (baseStat != null) 'base_stat': baseStat,
    });
  }

  PokemonStatsCompanion copyWith({
    Value<int>? id,
    Value<int>? pokemonId,
    Value<String>? statName,
    Value<int>? baseStat,
  }) {
    return PokemonStatsCompanion(
      id: id ?? this.id,
      pokemonId: pokemonId ?? this.pokemonId,
      statName: statName ?? this.statName,
      baseStat: baseStat ?? this.baseStat,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (statName.present) {
      map['stat_name'] = Variable<String>(statName.value);
    }
    if (baseStat.present) {
      map['base_stat'] = Variable<int>(baseStat.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonStatsCompanion(')
          ..write('id: $id, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('statName: $statName, ')
          ..write('baseStat: $baseStat')
          ..write(')'))
        .toString();
  }
}

class $PokemonAbilitiesTable extends PokemonAbilities
    with TableInfo<$PokemonAbilitiesTable, PokemonAbility> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonAbilitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemons (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _abilityNameMeta = const VerificationMeta(
    'abilityName',
  );
  @override
  late final GeneratedColumn<String> abilityName = GeneratedColumn<String>(
    'ability_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _shortEffectMeta = const VerificationMeta(
    'shortEffect',
  );
  @override
  late final GeneratedColumn<String> shortEffect = GeneratedColumn<String>(
    'short_effect',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pokemonId,
    abilityName,
    isHidden,
    shortEffect,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_abilities';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonAbility> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('ability_name')) {
      context.handle(
        _abilityNameMeta,
        abilityName.isAcceptableOrUnknown(
          data['ability_name']!,
          _abilityNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_abilityNameMeta);
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    }
    if (data.containsKey('short_effect')) {
      context.handle(
        _shortEffectMeta,
        shortEffect.isAcceptableOrUnknown(
          data['short_effect']!,
          _shortEffectMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonAbility map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonAbility(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      abilityName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ability_name'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
      )!,
      shortEffect: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_effect'],
      ),
    );
  }

  @override
  $PokemonAbilitiesTable createAlias(String alias) {
    return $PokemonAbilitiesTable(attachedDatabase, alias);
  }
}

class PokemonAbility extends DataClass implements Insertable<PokemonAbility> {
  final int id;
  final int pokemonId;
  final String abilityName;
  final bool isHidden;
  final String? shortEffect;
  const PokemonAbility({
    required this.id,
    required this.pokemonId,
    required this.abilityName,
    required this.isHidden,
    this.shortEffect,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['ability_name'] = Variable<String>(abilityName);
    map['is_hidden'] = Variable<bool>(isHidden);
    if (!nullToAbsent || shortEffect != null) {
      map['short_effect'] = Variable<String>(shortEffect);
    }
    return map;
  }

  PokemonAbilitiesCompanion toCompanion(bool nullToAbsent) {
    return PokemonAbilitiesCompanion(
      id: Value(id),
      pokemonId: Value(pokemonId),
      abilityName: Value(abilityName),
      isHidden: Value(isHidden),
      shortEffect: shortEffect == null && nullToAbsent
          ? const Value.absent()
          : Value(shortEffect),
    );
  }

  factory PokemonAbility.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonAbility(
      id: serializer.fromJson<int>(json['id']),
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      abilityName: serializer.fromJson<String>(json['abilityName']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
      shortEffect: serializer.fromJson<String?>(json['shortEffect']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pokemonId': serializer.toJson<int>(pokemonId),
      'abilityName': serializer.toJson<String>(abilityName),
      'isHidden': serializer.toJson<bool>(isHidden),
      'shortEffect': serializer.toJson<String?>(shortEffect),
    };
  }

  PokemonAbility copyWith({
    int? id,
    int? pokemonId,
    String? abilityName,
    bool? isHidden,
    Value<String?> shortEffect = const Value.absent(),
  }) => PokemonAbility(
    id: id ?? this.id,
    pokemonId: pokemonId ?? this.pokemonId,
    abilityName: abilityName ?? this.abilityName,
    isHidden: isHidden ?? this.isHidden,
    shortEffect: shortEffect.present ? shortEffect.value : this.shortEffect,
  );
  PokemonAbility copyWithCompanion(PokemonAbilitiesCompanion data) {
    return PokemonAbility(
      id: data.id.present ? data.id.value : this.id,
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      abilityName: data.abilityName.present
          ? data.abilityName.value
          : this.abilityName,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
      shortEffect: data.shortEffect.present
          ? data.shortEffect.value
          : this.shortEffect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonAbility(')
          ..write('id: $id, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('abilityName: $abilityName, ')
          ..write('isHidden: $isHidden, ')
          ..write('shortEffect: $shortEffect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pokemonId, abilityName, isHidden, shortEffect);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonAbility &&
          other.id == this.id &&
          other.pokemonId == this.pokemonId &&
          other.abilityName == this.abilityName &&
          other.isHidden == this.isHidden &&
          other.shortEffect == this.shortEffect);
}

class PokemonAbilitiesCompanion extends UpdateCompanion<PokemonAbility> {
  final Value<int> id;
  final Value<int> pokemonId;
  final Value<String> abilityName;
  final Value<bool> isHidden;
  final Value<String?> shortEffect;
  const PokemonAbilitiesCompanion({
    this.id = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.abilityName = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.shortEffect = const Value.absent(),
  });
  PokemonAbilitiesCompanion.insert({
    this.id = const Value.absent(),
    required int pokemonId,
    required String abilityName,
    this.isHidden = const Value.absent(),
    this.shortEffect = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       abilityName = Value(abilityName);
  static Insertable<PokemonAbility> custom({
    Expression<int>? id,
    Expression<int>? pokemonId,
    Expression<String>? abilityName,
    Expression<bool>? isHidden,
    Expression<String>? shortEffect,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (abilityName != null) 'ability_name': abilityName,
      if (isHidden != null) 'is_hidden': isHidden,
      if (shortEffect != null) 'short_effect': shortEffect,
    });
  }

  PokemonAbilitiesCompanion copyWith({
    Value<int>? id,
    Value<int>? pokemonId,
    Value<String>? abilityName,
    Value<bool>? isHidden,
    Value<String?>? shortEffect,
  }) {
    return PokemonAbilitiesCompanion(
      id: id ?? this.id,
      pokemonId: pokemonId ?? this.pokemonId,
      abilityName: abilityName ?? this.abilityName,
      isHidden: isHidden ?? this.isHidden,
      shortEffect: shortEffect ?? this.shortEffect,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (abilityName.present) {
      map['ability_name'] = Variable<String>(abilityName.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    if (shortEffect.present) {
      map['short_effect'] = Variable<String>(shortEffect.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonAbilitiesCompanion(')
          ..write('id: $id, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('abilityName: $abilityName, ')
          ..write('isHidden: $isHidden, ')
          ..write('shortEffect: $shortEffect')
          ..write(')'))
        .toString();
  }
}

class $PokemonMovesTable extends PokemonMoves
    with TableInfo<$PokemonMovesTable, PokemonMove> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonMovesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemons (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _moveIdMeta = const VerificationMeta('moveId');
  @override
  late final GeneratedColumn<int> moveId = GeneratedColumn<int>(
    'move_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moveNameMeta = const VerificationMeta(
    'moveName',
  );
  @override
  late final GeneratedColumn<String> moveName = GeneratedColumn<String>(
    'move_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeNameMeta = const VerificationMeta(
    'typeName',
  );
  @override
  late final GeneratedColumn<String> typeName = GeneratedColumn<String>(
    'type_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _powerMeta = const VerificationMeta('power');
  @override
  late final GeneratedColumn<int> power = GeneratedColumn<int>(
    'power',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<int> accuracy = GeneratedColumn<int>(
    'accuracy',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ppMeta = const VerificationMeta('pp');
  @override
  late final GeneratedColumn<int> pp = GeneratedColumn<int>(
    'pp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _learnMethodMeta = const VerificationMeta(
    'learnMethod',
  );
  @override
  late final GeneratedColumn<String> learnMethod = GeneratedColumn<String>(
    'learn_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('level-up'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pokemonId,
    moveId,
    moveName,
    typeName,
    power,
    accuracy,
    pp,
    level,
    learnMethod,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_moves';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonMove> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('move_id')) {
      context.handle(
        _moveIdMeta,
        moveId.isAcceptableOrUnknown(data['move_id']!, _moveIdMeta),
      );
    } else if (isInserting) {
      context.missing(_moveIdMeta);
    }
    if (data.containsKey('move_name')) {
      context.handle(
        _moveNameMeta,
        moveName.isAcceptableOrUnknown(data['move_name']!, _moveNameMeta),
      );
    } else if (isInserting) {
      context.missing(_moveNameMeta);
    }
    if (data.containsKey('type_name')) {
      context.handle(
        _typeNameMeta,
        typeName.isAcceptableOrUnknown(data['type_name']!, _typeNameMeta),
      );
    } else if (isInserting) {
      context.missing(_typeNameMeta);
    }
    if (data.containsKey('power')) {
      context.handle(
        _powerMeta,
        power.isAcceptableOrUnknown(data['power']!, _powerMeta),
      );
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    }
    if (data.containsKey('pp')) {
      context.handle(_ppMeta, pp.isAcceptableOrUnknown(data['pp']!, _ppMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('learn_method')) {
      context.handle(
        _learnMethodMeta,
        learnMethod.isAcceptableOrUnknown(
          data['learn_method']!,
          _learnMethodMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonMove map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonMove(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      moveId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}move_id'],
      )!,
      moveName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}move_name'],
      )!,
      typeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_name'],
      )!,
      power: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}power'],
      ),
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}accuracy'],
      ),
      pp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pp'],
      ),
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      learnMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}learn_method'],
      )!,
    );
  }

  @override
  $PokemonMovesTable createAlias(String alias) {
    return $PokemonMovesTable(attachedDatabase, alias);
  }
}

class PokemonMove extends DataClass implements Insertable<PokemonMove> {
  final int id;
  final int pokemonId;
  final int moveId;
  final String moveName;
  final String typeName;
  final int? power;
  final int? accuracy;
  final int? pp;
  final int level;
  final String learnMethod;
  const PokemonMove({
    required this.id,
    required this.pokemonId,
    required this.moveId,
    required this.moveName,
    required this.typeName,
    this.power,
    this.accuracy,
    this.pp,
    required this.level,
    required this.learnMethod,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['move_id'] = Variable<int>(moveId);
    map['move_name'] = Variable<String>(moveName);
    map['type_name'] = Variable<String>(typeName);
    if (!nullToAbsent || power != null) {
      map['power'] = Variable<int>(power);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<int>(accuracy);
    }
    if (!nullToAbsent || pp != null) {
      map['pp'] = Variable<int>(pp);
    }
    map['level'] = Variable<int>(level);
    map['learn_method'] = Variable<String>(learnMethod);
    return map;
  }

  PokemonMovesCompanion toCompanion(bool nullToAbsent) {
    return PokemonMovesCompanion(
      id: Value(id),
      pokemonId: Value(pokemonId),
      moveId: Value(moveId),
      moveName: Value(moveName),
      typeName: Value(typeName),
      power: power == null && nullToAbsent
          ? const Value.absent()
          : Value(power),
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      pp: pp == null && nullToAbsent ? const Value.absent() : Value(pp),
      level: Value(level),
      learnMethod: Value(learnMethod),
    );
  }

  factory PokemonMove.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonMove(
      id: serializer.fromJson<int>(json['id']),
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      moveId: serializer.fromJson<int>(json['moveId']),
      moveName: serializer.fromJson<String>(json['moveName']),
      typeName: serializer.fromJson<String>(json['typeName']),
      power: serializer.fromJson<int?>(json['power']),
      accuracy: serializer.fromJson<int?>(json['accuracy']),
      pp: serializer.fromJson<int?>(json['pp']),
      level: serializer.fromJson<int>(json['level']),
      learnMethod: serializer.fromJson<String>(json['learnMethod']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pokemonId': serializer.toJson<int>(pokemonId),
      'moveId': serializer.toJson<int>(moveId),
      'moveName': serializer.toJson<String>(moveName),
      'typeName': serializer.toJson<String>(typeName),
      'power': serializer.toJson<int?>(power),
      'accuracy': serializer.toJson<int?>(accuracy),
      'pp': serializer.toJson<int?>(pp),
      'level': serializer.toJson<int>(level),
      'learnMethod': serializer.toJson<String>(learnMethod),
    };
  }

  PokemonMove copyWith({
    int? id,
    int? pokemonId,
    int? moveId,
    String? moveName,
    String? typeName,
    Value<int?> power = const Value.absent(),
    Value<int?> accuracy = const Value.absent(),
    Value<int?> pp = const Value.absent(),
    int? level,
    String? learnMethod,
  }) => PokemonMove(
    id: id ?? this.id,
    pokemonId: pokemonId ?? this.pokemonId,
    moveId: moveId ?? this.moveId,
    moveName: moveName ?? this.moveName,
    typeName: typeName ?? this.typeName,
    power: power.present ? power.value : this.power,
    accuracy: accuracy.present ? accuracy.value : this.accuracy,
    pp: pp.present ? pp.value : this.pp,
    level: level ?? this.level,
    learnMethod: learnMethod ?? this.learnMethod,
  );
  PokemonMove copyWithCompanion(PokemonMovesCompanion data) {
    return PokemonMove(
      id: data.id.present ? data.id.value : this.id,
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      moveId: data.moveId.present ? data.moveId.value : this.moveId,
      moveName: data.moveName.present ? data.moveName.value : this.moveName,
      typeName: data.typeName.present ? data.typeName.value : this.typeName,
      power: data.power.present ? data.power.value : this.power,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      pp: data.pp.present ? data.pp.value : this.pp,
      level: data.level.present ? data.level.value : this.level,
      learnMethod: data.learnMethod.present
          ? data.learnMethod.value
          : this.learnMethod,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonMove(')
          ..write('id: $id, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('moveId: $moveId, ')
          ..write('moveName: $moveName, ')
          ..write('typeName: $typeName, ')
          ..write('power: $power, ')
          ..write('accuracy: $accuracy, ')
          ..write('pp: $pp, ')
          ..write('level: $level, ')
          ..write('learnMethod: $learnMethod')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pokemonId,
    moveId,
    moveName,
    typeName,
    power,
    accuracy,
    pp,
    level,
    learnMethod,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonMove &&
          other.id == this.id &&
          other.pokemonId == this.pokemonId &&
          other.moveId == this.moveId &&
          other.moveName == this.moveName &&
          other.typeName == this.typeName &&
          other.power == this.power &&
          other.accuracy == this.accuracy &&
          other.pp == this.pp &&
          other.level == this.level &&
          other.learnMethod == this.learnMethod);
}

class PokemonMovesCompanion extends UpdateCompanion<PokemonMove> {
  final Value<int> id;
  final Value<int> pokemonId;
  final Value<int> moveId;
  final Value<String> moveName;
  final Value<String> typeName;
  final Value<int?> power;
  final Value<int?> accuracy;
  final Value<int?> pp;
  final Value<int> level;
  final Value<String> learnMethod;
  const PokemonMovesCompanion({
    this.id = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.moveId = const Value.absent(),
    this.moveName = const Value.absent(),
    this.typeName = const Value.absent(),
    this.power = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.pp = const Value.absent(),
    this.level = const Value.absent(),
    this.learnMethod = const Value.absent(),
  });
  PokemonMovesCompanion.insert({
    this.id = const Value.absent(),
    required int pokemonId,
    required int moveId,
    required String moveName,
    required String typeName,
    this.power = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.pp = const Value.absent(),
    this.level = const Value.absent(),
    this.learnMethod = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       moveId = Value(moveId),
       moveName = Value(moveName),
       typeName = Value(typeName);
  static Insertable<PokemonMove> custom({
    Expression<int>? id,
    Expression<int>? pokemonId,
    Expression<int>? moveId,
    Expression<String>? moveName,
    Expression<String>? typeName,
    Expression<int>? power,
    Expression<int>? accuracy,
    Expression<int>? pp,
    Expression<int>? level,
    Expression<String>? learnMethod,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (moveId != null) 'move_id': moveId,
      if (moveName != null) 'move_name': moveName,
      if (typeName != null) 'type_name': typeName,
      if (power != null) 'power': power,
      if (accuracy != null) 'accuracy': accuracy,
      if (pp != null) 'pp': pp,
      if (level != null) 'level': level,
      if (learnMethod != null) 'learn_method': learnMethod,
    });
  }

  PokemonMovesCompanion copyWith({
    Value<int>? id,
    Value<int>? pokemonId,
    Value<int>? moveId,
    Value<String>? moveName,
    Value<String>? typeName,
    Value<int?>? power,
    Value<int?>? accuracy,
    Value<int?>? pp,
    Value<int>? level,
    Value<String>? learnMethod,
  }) {
    return PokemonMovesCompanion(
      id: id ?? this.id,
      pokemonId: pokemonId ?? this.pokemonId,
      moveId: moveId ?? this.moveId,
      moveName: moveName ?? this.moveName,
      typeName: typeName ?? this.typeName,
      power: power ?? this.power,
      accuracy: accuracy ?? this.accuracy,
      pp: pp ?? this.pp,
      level: level ?? this.level,
      learnMethod: learnMethod ?? this.learnMethod,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (moveId.present) {
      map['move_id'] = Variable<int>(moveId.value);
    }
    if (moveName.present) {
      map['move_name'] = Variable<String>(moveName.value);
    }
    if (typeName.present) {
      map['type_name'] = Variable<String>(typeName.value);
    }
    if (power.present) {
      map['power'] = Variable<int>(power.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<int>(accuracy.value);
    }
    if (pp.present) {
      map['pp'] = Variable<int>(pp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (learnMethod.present) {
      map['learn_method'] = Variable<String>(learnMethod.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonMovesCompanion(')
          ..write('id: $id, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('moveId: $moveId, ')
          ..write('moveName: $moveName, ')
          ..write('typeName: $typeName, ')
          ..write('power: $power, ')
          ..write('accuracy: $accuracy, ')
          ..write('pp: $pp, ')
          ..write('level: $level, ')
          ..write('learnMethod: $learnMethod')
          ..write(')'))
        .toString();
  }
}

class $PokemonEvolutionsTable extends PokemonEvolutions
    with TableInfo<$PokemonEvolutionsTable, PokemonEvolution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonEvolutionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _chainIdMeta = const VerificationMeta(
    'chainId',
  );
  @override
  late final GeneratedColumn<int> chainId = GeneratedColumn<int>(
    'chain_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesNameMeta = const VerificationMeta(
    'speciesName',
  );
  @override
  late final GeneratedColumn<String> speciesName = GeneratedColumn<String>(
    'species_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _evolvesFromIdMeta = const VerificationMeta(
    'evolvesFromId',
  );
  @override
  late final GeneratedColumn<int> evolvesFromId = GeneratedColumn<int>(
    'evolves_from_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _triggerNameMeta = const VerificationMeta(
    'triggerName',
  );
  @override
  late final GeneratedColumn<String> triggerName = GeneratedColumn<String>(
    'trigger_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minLevelMeta = const VerificationMeta(
    'minLevel',
  );
  @override
  late final GeneratedColumn<int> minLevel = GeneratedColumn<int>(
    'min_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    chainId,
    speciesId,
    speciesName,
    evolvesFromId,
    triggerName,
    minLevel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_evolutions';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonEvolution> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chain_id')) {
      context.handle(
        _chainIdMeta,
        chainId.isAcceptableOrUnknown(data['chain_id']!, _chainIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chainIdMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('species_name')) {
      context.handle(
        _speciesNameMeta,
        speciesName.isAcceptableOrUnknown(
          data['species_name']!,
          _speciesNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_speciesNameMeta);
    }
    if (data.containsKey('evolves_from_id')) {
      context.handle(
        _evolvesFromIdMeta,
        evolvesFromId.isAcceptableOrUnknown(
          data['evolves_from_id']!,
          _evolvesFromIdMeta,
        ),
      );
    }
    if (data.containsKey('trigger_name')) {
      context.handle(
        _triggerNameMeta,
        triggerName.isAcceptableOrUnknown(
          data['trigger_name']!,
          _triggerNameMeta,
        ),
      );
    }
    if (data.containsKey('min_level')) {
      context.handle(
        _minLevelMeta,
        minLevel.isAcceptableOrUnknown(data['min_level']!, _minLevelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonEvolution map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonEvolution(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      chainId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chain_id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      )!,
      speciesName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species_name'],
      )!,
      evolvesFromId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}evolves_from_id'],
      ),
      triggerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger_name'],
      ),
      minLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_level'],
      ),
    );
  }

  @override
  $PokemonEvolutionsTable createAlias(String alias) {
    return $PokemonEvolutionsTable(attachedDatabase, alias);
  }
}

class PokemonEvolution extends DataClass
    implements Insertable<PokemonEvolution> {
  final int id;
  final int chainId;
  final int speciesId;
  final String speciesName;
  final int? evolvesFromId;
  final String? triggerName;
  final int? minLevel;
  const PokemonEvolution({
    required this.id,
    required this.chainId,
    required this.speciesId,
    required this.speciesName,
    this.evolvesFromId,
    this.triggerName,
    this.minLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chain_id'] = Variable<int>(chainId);
    map['species_id'] = Variable<int>(speciesId);
    map['species_name'] = Variable<String>(speciesName);
    if (!nullToAbsent || evolvesFromId != null) {
      map['evolves_from_id'] = Variable<int>(evolvesFromId);
    }
    if (!nullToAbsent || triggerName != null) {
      map['trigger_name'] = Variable<String>(triggerName);
    }
    if (!nullToAbsent || minLevel != null) {
      map['min_level'] = Variable<int>(minLevel);
    }
    return map;
  }

  PokemonEvolutionsCompanion toCompanion(bool nullToAbsent) {
    return PokemonEvolutionsCompanion(
      id: Value(id),
      chainId: Value(chainId),
      speciesId: Value(speciesId),
      speciesName: Value(speciesName),
      evolvesFromId: evolvesFromId == null && nullToAbsent
          ? const Value.absent()
          : Value(evolvesFromId),
      triggerName: triggerName == null && nullToAbsent
          ? const Value.absent()
          : Value(triggerName),
      minLevel: minLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(minLevel),
    );
  }

  factory PokemonEvolution.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonEvolution(
      id: serializer.fromJson<int>(json['id']),
      chainId: serializer.fromJson<int>(json['chainId']),
      speciesId: serializer.fromJson<int>(json['speciesId']),
      speciesName: serializer.fromJson<String>(json['speciesName']),
      evolvesFromId: serializer.fromJson<int?>(json['evolvesFromId']),
      triggerName: serializer.fromJson<String?>(json['triggerName']),
      minLevel: serializer.fromJson<int?>(json['minLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chainId': serializer.toJson<int>(chainId),
      'speciesId': serializer.toJson<int>(speciesId),
      'speciesName': serializer.toJson<String>(speciesName),
      'evolvesFromId': serializer.toJson<int?>(evolvesFromId),
      'triggerName': serializer.toJson<String?>(triggerName),
      'minLevel': serializer.toJson<int?>(minLevel),
    };
  }

  PokemonEvolution copyWith({
    int? id,
    int? chainId,
    int? speciesId,
    String? speciesName,
    Value<int?> evolvesFromId = const Value.absent(),
    Value<String?> triggerName = const Value.absent(),
    Value<int?> minLevel = const Value.absent(),
  }) => PokemonEvolution(
    id: id ?? this.id,
    chainId: chainId ?? this.chainId,
    speciesId: speciesId ?? this.speciesId,
    speciesName: speciesName ?? this.speciesName,
    evolvesFromId: evolvesFromId.present
        ? evolvesFromId.value
        : this.evolvesFromId,
    triggerName: triggerName.present ? triggerName.value : this.triggerName,
    minLevel: minLevel.present ? minLevel.value : this.minLevel,
  );
  PokemonEvolution copyWithCompanion(PokemonEvolutionsCompanion data) {
    return PokemonEvolution(
      id: data.id.present ? data.id.value : this.id,
      chainId: data.chainId.present ? data.chainId.value : this.chainId,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      speciesName: data.speciesName.present
          ? data.speciesName.value
          : this.speciesName,
      evolvesFromId: data.evolvesFromId.present
          ? data.evolvesFromId.value
          : this.evolvesFromId,
      triggerName: data.triggerName.present
          ? data.triggerName.value
          : this.triggerName,
      minLevel: data.minLevel.present ? data.minLevel.value : this.minLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonEvolution(')
          ..write('id: $id, ')
          ..write('chainId: $chainId, ')
          ..write('speciesId: $speciesId, ')
          ..write('speciesName: $speciesName, ')
          ..write('evolvesFromId: $evolvesFromId, ')
          ..write('triggerName: $triggerName, ')
          ..write('minLevel: $minLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    chainId,
    speciesId,
    speciesName,
    evolvesFromId,
    triggerName,
    minLevel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonEvolution &&
          other.id == this.id &&
          other.chainId == this.chainId &&
          other.speciesId == this.speciesId &&
          other.speciesName == this.speciesName &&
          other.evolvesFromId == this.evolvesFromId &&
          other.triggerName == this.triggerName &&
          other.minLevel == this.minLevel);
}

class PokemonEvolutionsCompanion extends UpdateCompanion<PokemonEvolution> {
  final Value<int> id;
  final Value<int> chainId;
  final Value<int> speciesId;
  final Value<String> speciesName;
  final Value<int?> evolvesFromId;
  final Value<String?> triggerName;
  final Value<int?> minLevel;
  const PokemonEvolutionsCompanion({
    this.id = const Value.absent(),
    this.chainId = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.speciesName = const Value.absent(),
    this.evolvesFromId = const Value.absent(),
    this.triggerName = const Value.absent(),
    this.minLevel = const Value.absent(),
  });
  PokemonEvolutionsCompanion.insert({
    this.id = const Value.absent(),
    required int chainId,
    required int speciesId,
    required String speciesName,
    this.evolvesFromId = const Value.absent(),
    this.triggerName = const Value.absent(),
    this.minLevel = const Value.absent(),
  }) : chainId = Value(chainId),
       speciesId = Value(speciesId),
       speciesName = Value(speciesName);
  static Insertable<PokemonEvolution> custom({
    Expression<int>? id,
    Expression<int>? chainId,
    Expression<int>? speciesId,
    Expression<String>? speciesName,
    Expression<int>? evolvesFromId,
    Expression<String>? triggerName,
    Expression<int>? minLevel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chainId != null) 'chain_id': chainId,
      if (speciesId != null) 'species_id': speciesId,
      if (speciesName != null) 'species_name': speciesName,
      if (evolvesFromId != null) 'evolves_from_id': evolvesFromId,
      if (triggerName != null) 'trigger_name': triggerName,
      if (minLevel != null) 'min_level': minLevel,
    });
  }

  PokemonEvolutionsCompanion copyWith({
    Value<int>? id,
    Value<int>? chainId,
    Value<int>? speciesId,
    Value<String>? speciesName,
    Value<int?>? evolvesFromId,
    Value<String?>? triggerName,
    Value<int?>? minLevel,
  }) {
    return PokemonEvolutionsCompanion(
      id: id ?? this.id,
      chainId: chainId ?? this.chainId,
      speciesId: speciesId ?? this.speciesId,
      speciesName: speciesName ?? this.speciesName,
      evolvesFromId: evolvesFromId ?? this.evolvesFromId,
      triggerName: triggerName ?? this.triggerName,
      minLevel: minLevel ?? this.minLevel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chainId.present) {
      map['chain_id'] = Variable<int>(chainId.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (speciesName.present) {
      map['species_name'] = Variable<String>(speciesName.value);
    }
    if (evolvesFromId.present) {
      map['evolves_from_id'] = Variable<int>(evolvesFromId.value);
    }
    if (triggerName.present) {
      map['trigger_name'] = Variable<String>(triggerName.value);
    }
    if (minLevel.present) {
      map['min_level'] = Variable<int>(minLevel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonEvolutionsCompanion(')
          ..write('id: $id, ')
          ..write('chainId: $chainId, ')
          ..write('speciesId: $speciesId, ')
          ..write('speciesName: $speciesName, ')
          ..write('evolvesFromId: $evolvesFromId, ')
          ..write('triggerName: $triggerName, ')
          ..write('minLevel: $minLevel')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Favorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorite(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final int pokemonId;
  final DateTime addedAt;
  const Favorite({required this.pokemonId, required this.addedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      pokemonId: Value(pokemonId),
      addedAt: Value(addedAt),
    );
  }

  factory Favorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  Favorite copyWith({int? pokemonId, DateTime? addedAt}) => Favorite(
    pokemonId: pokemonId ?? this.pokemonId,
    addedAt: addedAt ?? this.addedAt,
  );
  Favorite copyWithCompanion(FavoritesCompanion data) {
    return Favorite(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('pokemonId: $pokemonId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.pokemonId == this.pokemonId &&
          other.addedAt == this.addedAt);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> pokemonId;
  final Value<DateTime> addedAt;
  const FavoritesCompanion({
    this.pokemonId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.pokemonId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  static Insertable<Favorite> custom({
    Expression<int>? pokemonId,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  FavoritesCompanion copyWith({
    Value<int>? pokemonId,
    Value<DateTime>? addedAt,
  }) {
    return FavoritesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $TriviaRecordsTable extends TriviaRecords
    with TableInfo<$TriviaRecordsTable, TriviaRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TriviaRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctAnswersMeta = const VerificationMeta(
    'correctAnswers',
  );
  @override
  late final GeneratedColumn<int> correctAnswers = GeneratedColumn<int>(
    'correct_answers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalQuestionsMeta = const VerificationMeta(
    'totalQuestions',
  );
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
    'total_questions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playedAtMeta = const VerificationMeta(
    'playedAt',
  );
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    score,
    correctAnswers,
    totalQuestions,
    playedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trivia_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<TriviaRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('correct_answers')) {
      context.handle(
        _correctAnswersMeta,
        correctAnswers.isAcceptableOrUnknown(
          data['correct_answers']!,
          _correctAnswersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctAnswersMeta);
    }
    if (data.containsKey('total_questions')) {
      context.handle(
        _totalQuestionsMeta,
        totalQuestions.isAcceptableOrUnknown(
          data['total_questions']!,
          _totalQuestionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalQuestionsMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TriviaRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TriviaRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      correctAnswers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_answers'],
      )!,
      totalQuestions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_questions'],
      )!,
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      )!,
    );
  }

  @override
  $TriviaRecordsTable createAlias(String alias) {
    return $TriviaRecordsTable(attachedDatabase, alias);
  }
}

class TriviaRecord extends DataClass implements Insertable<TriviaRecord> {
  final int id;
  final int score;
  final int correctAnswers;
  final int totalQuestions;
  final DateTime playedAt;
  const TriviaRecord({
    required this.id,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.playedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['score'] = Variable<int>(score);
    map['correct_answers'] = Variable<int>(correctAnswers);
    map['total_questions'] = Variable<int>(totalQuestions);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  TriviaRecordsCompanion toCompanion(bool nullToAbsent) {
    return TriviaRecordsCompanion(
      id: Value(id),
      score: Value(score),
      correctAnswers: Value(correctAnswers),
      totalQuestions: Value(totalQuestions),
      playedAt: Value(playedAt),
    );
  }

  factory TriviaRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TriviaRecord(
      id: serializer.fromJson<int>(json['id']),
      score: serializer.fromJson<int>(json['score']),
      correctAnswers: serializer.fromJson<int>(json['correctAnswers']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'score': serializer.toJson<int>(score),
      'correctAnswers': serializer.toJson<int>(correctAnswers),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  TriviaRecord copyWith({
    int? id,
    int? score,
    int? correctAnswers,
    int? totalQuestions,
    DateTime? playedAt,
  }) => TriviaRecord(
    id: id ?? this.id,
    score: score ?? this.score,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    playedAt: playedAt ?? this.playedAt,
  );
  TriviaRecord copyWithCompanion(TriviaRecordsCompanion data) {
    return TriviaRecord(
      id: data.id.present ? data.id.value : this.id,
      score: data.score.present ? data.score.value : this.score,
      correctAnswers: data.correctAnswers.present
          ? data.correctAnswers.value
          : this.correctAnswers,
      totalQuestions: data.totalQuestions.present
          ? data.totalQuestions.value
          : this.totalQuestions,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TriviaRecord(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, score, correctAnswers, totalQuestions, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TriviaRecord &&
          other.id == this.id &&
          other.score == this.score &&
          other.correctAnswers == this.correctAnswers &&
          other.totalQuestions == this.totalQuestions &&
          other.playedAt == this.playedAt);
}

class TriviaRecordsCompanion extends UpdateCompanion<TriviaRecord> {
  final Value<int> id;
  final Value<int> score;
  final Value<int> correctAnswers;
  final Value<int> totalQuestions;
  final Value<DateTime> playedAt;
  const TriviaRecordsCompanion({
    this.id = const Value.absent(),
    this.score = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  TriviaRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int score,
    required int correctAnswers,
    required int totalQuestions,
    this.playedAt = const Value.absent(),
  }) : score = Value(score),
       correctAnswers = Value(correctAnswers),
       totalQuestions = Value(totalQuestions);
  static Insertable<TriviaRecord> custom({
    Expression<int>? id,
    Expression<int>? score,
    Expression<int>? correctAnswers,
    Expression<int>? totalQuestions,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (score != null) 'score': score,
      if (correctAnswers != null) 'correct_answers': correctAnswers,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  TriviaRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? score,
    Value<int>? correctAnswers,
    Value<int>? totalQuestions,
    Value<DateTime>? playedAt,
  }) {
    return TriviaRecordsCompanion(
      id: id ?? this.id,
      score: score ?? this.score,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (correctAnswers.present) {
      map['correct_answers'] = Variable<int>(correctAnswers.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TriviaRecordsCompanion(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTable extends SyncMetadata
    with TableInfo<$SyncMetadataTable, SyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncTimeMeta = const VerificationMeta(
    'lastSyncTime',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncTime = GeneratedColumn<DateTime>(
    'last_sync_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalRecordsMeta = const VerificationMeta(
    'totalRecords',
  );
  @override
  late final GeneratedColumn<int> totalRecords = GeneratedColumn<int>(
    'total_records',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [key, lastSyncTime, totalRecords];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('last_sync_time')) {
      context.handle(
        _lastSyncTimeMeta,
        lastSyncTime.isAcceptableOrUnknown(
          data['last_sync_time']!,
          _lastSyncTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSyncTimeMeta);
    }
    if (data.containsKey('total_records')) {
      context.handle(
        _totalRecordsMeta,
        totalRecords.isAcceptableOrUnknown(
          data['total_records']!,
          _totalRecordsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      lastSyncTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync_time'],
      )!,
      totalRecords: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_records'],
      )!,
    );
  }

  @override
  $SyncMetadataTable createAlias(String alias) {
    return $SyncMetadataTable(attachedDatabase, alias);
  }
}

class SyncMetadataData extends DataClass
    implements Insertable<SyncMetadataData> {
  final String key;
  final DateTime lastSyncTime;
  final int totalRecords;
  const SyncMetadataData({
    required this.key,
    required this.lastSyncTime,
    required this.totalRecords,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['last_sync_time'] = Variable<DateTime>(lastSyncTime);
    map['total_records'] = Variable<int>(totalRecords);
    return map;
  }

  SyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataCompanion(
      key: Value(key),
      lastSyncTime: Value(lastSyncTime),
      totalRecords: Value(totalRecords),
    );
  }

  factory SyncMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataData(
      key: serializer.fromJson<String>(json['key']),
      lastSyncTime: serializer.fromJson<DateTime>(json['lastSyncTime']),
      totalRecords: serializer.fromJson<int>(json['totalRecords']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'lastSyncTime': serializer.toJson<DateTime>(lastSyncTime),
      'totalRecords': serializer.toJson<int>(totalRecords),
    };
  }

  SyncMetadataData copyWith({
    String? key,
    DateTime? lastSyncTime,
    int? totalRecords,
  }) => SyncMetadataData(
    key: key ?? this.key,
    lastSyncTime: lastSyncTime ?? this.lastSyncTime,
    totalRecords: totalRecords ?? this.totalRecords,
  );
  SyncMetadataData copyWithCompanion(SyncMetadataCompanion data) {
    return SyncMetadataData(
      key: data.key.present ? data.key.value : this.key,
      lastSyncTime: data.lastSyncTime.present
          ? data.lastSyncTime.value
          : this.lastSyncTime,
      totalRecords: data.totalRecords.present
          ? data.totalRecords.value
          : this.totalRecords,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataData(')
          ..write('key: $key, ')
          ..write('lastSyncTime: $lastSyncTime, ')
          ..write('totalRecords: $totalRecords')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, lastSyncTime, totalRecords);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataData &&
          other.key == this.key &&
          other.lastSyncTime == this.lastSyncTime &&
          other.totalRecords == this.totalRecords);
}

class SyncMetadataCompanion extends UpdateCompanion<SyncMetadataData> {
  final Value<String> key;
  final Value<DateTime> lastSyncTime;
  final Value<int> totalRecords;
  final Value<int> rowid;
  const SyncMetadataCompanion({
    this.key = const Value.absent(),
    this.lastSyncTime = const Value.absent(),
    this.totalRecords = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataCompanion.insert({
    required String key,
    required DateTime lastSyncTime,
    this.totalRecords = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       lastSyncTime = Value(lastSyncTime);
  static Insertable<SyncMetadataData> custom({
    Expression<String>? key,
    Expression<DateTime>? lastSyncTime,
    Expression<int>? totalRecords,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (lastSyncTime != null) 'last_sync_time': lastSyncTime,
      if (totalRecords != null) 'total_records': totalRecords,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataCompanion copyWith({
    Value<String>? key,
    Value<DateTime>? lastSyncTime,
    Value<int>? totalRecords,
    Value<int>? rowid,
  }) {
    return SyncMetadataCompanion(
      key: key ?? this.key,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      totalRecords: totalRecords ?? this.totalRecords,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (lastSyncTime.present) {
      map['last_sync_time'] = Variable<DateTime>(lastSyncTime.value);
    }
    if (totalRecords.present) {
      map['total_records'] = Variable<int>(totalRecords.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataCompanion(')
          ..write('key: $key, ')
          ..write('lastSyncTime: $lastSyncTime, ')
          ..write('totalRecords: $totalRecords, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PokemonsTable pokemons = $PokemonsTable(this);
  late final $PokemonTypesTable pokemonTypes = $PokemonTypesTable(this);
  late final $PokemonStatsTable pokemonStats = $PokemonStatsTable(this);
  late final $PokemonAbilitiesTable pokemonAbilities = $PokemonAbilitiesTable(
    this,
  );
  late final $PokemonMovesTable pokemonMoves = $PokemonMovesTable(this);
  late final $PokemonEvolutionsTable pokemonEvolutions =
      $PokemonEvolutionsTable(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $TriviaRecordsTable triviaRecords = $TriviaRecordsTable(this);
  late final $SyncMetadataTable syncMetadata = $SyncMetadataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pokemons,
    pokemonTypes,
    pokemonStats,
    pokemonAbilities,
    pokemonMoves,
    pokemonEvolutions,
    favorites,
    triviaRecords,
    syncMetadata,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemons',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_types', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemons',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_stats', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemons',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_abilities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemons',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_moves', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PokemonsTableCreateCompanionBuilder = PokemonsCompanion Function({
  Value<int> id,
  required String name,
  required int height,
  required int weight,
  Value<int?> baseExperience,
  Value<int> generationId,
  Value<String?> flavorText,
  Value<String?> speciesGenus,
  Value<int?> evolutionChainId,
  Value<String?> contentHash,
  Value<DateTime> updatedAt,
});
typedef $$PokemonsTableUpdateCompanionBuilder = PokemonsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> height,
  Value<int> weight,
  Value<int?> baseExperience,
  Value<int> generationId,
  Value<String?> flavorText,
  Value<String?> speciesGenus,
  Value<int?> evolutionChainId,
  Value<String?> contentHash,
  Value<DateTime> updatedAt,
});

final class $$PokemonsTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonsTable, Pokemon> {
  $$PokemonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonTypesTable, List<PokemonType>>
  _pokemonTypesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonTypes,
    aliasName: 'pokemons__id__pokemon_types__pokemon_id',
  );

  $$PokemonTypesTableProcessedTableManager get pokemonTypesRefs {
    final manager = $$PokemonTypesTableTableManager(
      $_db,
      $_db.pokemonTypes,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonTypesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonStatsTable, List<PokemonStat>>
  _pokemonStatsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonStats,
    aliasName: 'pokemons__id__pokemon_stats__pokemon_id',
  );

  $$PokemonStatsTableProcessedTableManager get pokemonStatsRefs {
    final manager = $$PokemonStatsTableTableManager(
      $_db,
      $_db.pokemonStats,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonStatsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonAbilitiesTable, List<PokemonAbility>>
  _pokemonAbilitiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonAbilities,
    aliasName: 'pokemons__id__pokemon_abilities__pokemon_id',
  );

  $$PokemonAbilitiesTableProcessedTableManager get pokemonAbilitiesRefs {
    final manager = $$PokemonAbilitiesTableTableManager(
      $_db,
      $_db.pokemonAbilities,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonAbilitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonMovesTable, List<PokemonMove>>
  _pokemonMovesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonMoves,
    aliasName: 'pokemons__id__pokemon_moves__pokemon_id',
  );

  $$PokemonMovesTableProcessedTableManager get pokemonMovesRefs {
    final manager = $$PokemonMovesTableTableManager(
      $_db,
      $_db.pokemonMoves,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonMovesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PokemonsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonsTable> {
  $$PokemonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseExperience => $composableBuilder(
    column: $table.baseExperience,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flavorText => $composableBuilder(
    column: $table.flavorText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get speciesGenus => $composableBuilder(
    column: $table.speciesGenus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonTypesRefs(
    Expression<bool> Function($$PokemonTypesTableFilterComposer f) f,
  ) {
    final $$PokemonTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypes,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonStatsRefs(
    Expression<bool> Function($$PokemonStatsTableFilterComposer f) f,
  ) {
    final $$PokemonStatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonStats,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonStatsTableFilterComposer(
            $db: $db,
            $table: $db.pokemonStats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonAbilitiesRefs(
    Expression<bool> Function($$PokemonAbilitiesTableFilterComposer f) f,
  ) {
    final $$PokemonAbilitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonAbilities,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonAbilitiesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonAbilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonMovesRefs(
    Expression<bool> Function($$PokemonMovesTableFilterComposer f) f,
  ) {
    final $$PokemonMovesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonMoves,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonMovesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonMoves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PokemonsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonsTable> {
  $$PokemonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseExperience => $composableBuilder(
    column: $table.baseExperience,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flavorText => $composableBuilder(
    column: $table.flavorText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get speciesGenus => $composableBuilder(
    column: $table.speciesGenus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonsTable> {
  $$PokemonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get baseExperience => $composableBuilder(
    column: $table.baseExperience,
    builder: (column) => column,
  );

  GeneratedColumn<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get flavorText => $composableBuilder(
    column: $table.flavorText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get speciesGenus => $composableBuilder(
    column: $table.speciesGenus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> pokemonTypesRefs<T extends Object>(
    Expression<T> Function($$PokemonTypesTableAnnotationComposer a) f,
  ) {
    final $$PokemonTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypes,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pokemonStatsRefs<T extends Object>(
    Expression<T> Function($$PokemonStatsTableAnnotationComposer a) f,
  ) {
    final $$PokemonStatsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonStats,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonStatsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonStats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pokemonAbilitiesRefs<T extends Object>(
    Expression<T> Function($$PokemonAbilitiesTableAnnotationComposer a) f,
  ) {
    final $$PokemonAbilitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonAbilities,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonAbilitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonAbilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pokemonMovesRefs<T extends Object>(
    Expression<T> Function($$PokemonMovesTableAnnotationComposer a) f,
  ) {
    final $$PokemonMovesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonMoves,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonMovesTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonMoves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PokemonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonsTable,
          Pokemon,
          $$PokemonsTableFilterComposer,
          $$PokemonsTableOrderingComposer,
          $$PokemonsTableAnnotationComposer,
          $$PokemonsTableCreateCompanionBuilder,
          $$PokemonsTableUpdateCompanionBuilder,
          (Pokemon, $$PokemonsTableReferences),
          Pokemon,
          PrefetchHooks Function({
            bool pokemonTypesRefs,
            bool pokemonStatsRefs,
            bool pokemonAbilitiesRefs,
            bool pokemonMovesRefs,
          })
        > {
  $$PokemonsTableTableManager(_$AppDatabase db, $PokemonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> height = const Value.absent(),
                Value<int> weight = const Value.absent(),
                Value<int?> baseExperience = const Value.absent(),
                Value<int> generationId = const Value.absent(),
                Value<String?> flavorText = const Value.absent(),
                Value<String?> speciesGenus = const Value.absent(),
                Value<int?> evolutionChainId = const Value.absent(),
                Value<String?> contentHash = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PokemonsCompanion(
                id: id,
                name: name,
                height: height,
                weight: weight,
                baseExperience: baseExperience,
                generationId: generationId,
                flavorText: flavorText,
                speciesGenus: speciesGenus,
                evolutionChainId: evolutionChainId,
                contentHash: contentHash,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int height,
                required int weight,
                Value<int?> baseExperience = const Value.absent(),
                Value<int> generationId = const Value.absent(),
                Value<String?> flavorText = const Value.absent(),
                Value<String?> speciesGenus = const Value.absent(),
                Value<int?> evolutionChainId = const Value.absent(),
                Value<String?> contentHash = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PokemonsCompanion.insert(
                id: id,
                name: name,
                height: height,
                weight: weight,
                baseExperience: baseExperience,
                generationId: generationId,
                flavorText: flavorText,
                speciesGenus: speciesGenus,
                evolutionChainId: evolutionChainId,
                contentHash: contentHash,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonsTable, Pokemon>(table),
                  $$PokemonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pokemonTypesRefs = false,
                pokemonStatsRefs = false,
                pokemonAbilitiesRefs = false,
                pokemonMovesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonTypesRefs) db.pokemonTypes,
                    if (pokemonStatsRefs) db.pokemonStats,
                    if (pokemonAbilitiesRefs) db.pokemonAbilities,
                    if (pokemonMovesRefs) db.pokemonMoves,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pokemonTypesRefs)
                        await $_getPrefetchedDataByColumns<
                          Pokemon,
                          $PokemonsTable,
                          PokemonType,
                          $PokemonTypesTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._pokemonTypesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonTypesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonStatsRefs)
                        await $_getPrefetchedDataByColumns<
                          Pokemon,
                          $PokemonsTable,
                          PokemonStat,
                          $PokemonStatsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._pokemonStatsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonStatsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonAbilitiesRefs)
                        await $_getPrefetchedDataByColumns<
                          Pokemon,
                          $PokemonsTable,
                          PokemonAbility,
                          $PokemonAbilitiesTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._pokemonAbilitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonAbilitiesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonMovesRefs)
                        await $_getPrefetchedDataByColumns<
                          Pokemon,
                          $PokemonsTable,
                          PokemonMove,
                          $PokemonMovesTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._pokemonMovesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonMovesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PokemonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonsTable,
      Pokemon,
      $$PokemonsTableFilterComposer,
      $$PokemonsTableOrderingComposer,
      $$PokemonsTableAnnotationComposer,
      $$PokemonsTableCreateCompanionBuilder,
      $$PokemonsTableUpdateCompanionBuilder,
      (Pokemon, $$PokemonsTableReferences),
      Pokemon,
      PrefetchHooks Function({
        bool pokemonTypesRefs,
        bool pokemonStatsRefs,
        bool pokemonAbilitiesRefs,
        bool pokemonMovesRefs,
      })
    >;
typedef $$PokemonTypesTableCreateCompanionBuilder =
    PokemonTypesCompanion Function({
      Value<int> id,
      required int pokemonId,
      required int slot,
      required String typeName,
      required int typeId,
    });
typedef $$PokemonTypesTableUpdateCompanionBuilder =
    PokemonTypesCompanion Function({
      Value<int> id,
      Value<int> pokemonId,
      Value<int> slot,
      Value<String> typeName,
      Value<int> typeId,
    });

final class $$PokemonTypesTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonTypesTable, PokemonType> {
  $$PokemonTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_types__pokemon_id__pokemons__id');

  $$PokemonsTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonTypesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeName => $composableBuilder(
    column: $table.typeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonsTableFilterComposer get pokemonId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableFilterComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeName => $composableBuilder(
    column: $table.typeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonsTableOrderingComposer get pokemonId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableOrderingComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<String> get typeName =>
      $composableBuilder(column: $table.typeName, builder: (column) => column);

  GeneratedColumn<int> get typeId =>
      $composableBuilder(column: $table.typeId, builder: (column) => column);

  $$PokemonsTableAnnotationComposer get pokemonId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonTypesTable,
          PokemonType,
          $$PokemonTypesTableFilterComposer,
          $$PokemonTypesTableOrderingComposer,
          $$PokemonTypesTableAnnotationComposer,
          $$PokemonTypesTableCreateCompanionBuilder,
          $$PokemonTypesTableUpdateCompanionBuilder,
          (PokemonType, $$PokemonTypesTableReferences),
          PokemonType,
          PrefetchHooks Function({bool pokemonId})
        > {
  $$PokemonTypesTableTableManager(_$AppDatabase db, $PokemonTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> pokemonId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<String> typeName = const Value.absent(),
                Value<int> typeId = const Value.absent(),
              }) => PokemonTypesCompanion(
                id: id,
                pokemonId: pokemonId,
                slot: slot,
                typeName: typeName,
                typeId: typeId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int pokemonId,
                required int slot,
                required String typeName,
                required int typeId,
              }) => PokemonTypesCompanion.insert(
                id: id,
                pokemonId: pokemonId,
                slot: slot,
                typeName: typeName,
                typeId: typeId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonTypesTable, PokemonType>(table),
                  $$PokemonTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonTypesTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonTypesTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PokemonTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonTypesTable,
      PokemonType,
      $$PokemonTypesTableFilterComposer,
      $$PokemonTypesTableOrderingComposer,
      $$PokemonTypesTableAnnotationComposer,
      $$PokemonTypesTableCreateCompanionBuilder,
      $$PokemonTypesTableUpdateCompanionBuilder,
      (PokemonType, $$PokemonTypesTableReferences),
      PokemonType,
      PrefetchHooks Function({bool pokemonId})
    >;
typedef $$PokemonStatsTableCreateCompanionBuilder =
    PokemonStatsCompanion Function({
      Value<int> id,
      required int pokemonId,
      required String statName,
      required int baseStat,
    });
typedef $$PokemonStatsTableUpdateCompanionBuilder =
    PokemonStatsCompanion Function({
      Value<int> id,
      Value<int> pokemonId,
      Value<String> statName,
      Value<int> baseStat,
    });

final class $$PokemonStatsTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonStatsTable, PokemonStat> {
  $$PokemonStatsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_stats__pokemon_id__pokemons__id');

  $$PokemonsTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonStatsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonStatsTable> {
  $$PokemonStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statName => $composableBuilder(
    column: $table.statName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseStat => $composableBuilder(
    column: $table.baseStat,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonsTableFilterComposer get pokemonId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableFilterComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonStatsTable> {
  $$PokemonStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statName => $composableBuilder(
    column: $table.statName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseStat => $composableBuilder(
    column: $table.baseStat,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonsTableOrderingComposer get pokemonId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableOrderingComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonStatsTable> {
  $$PokemonStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get statName =>
      $composableBuilder(column: $table.statName, builder: (column) => column);

  GeneratedColumn<int> get baseStat =>
      $composableBuilder(column: $table.baseStat, builder: (column) => column);

  $$PokemonsTableAnnotationComposer get pokemonId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonStatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonStatsTable,
          PokemonStat,
          $$PokemonStatsTableFilterComposer,
          $$PokemonStatsTableOrderingComposer,
          $$PokemonStatsTableAnnotationComposer,
          $$PokemonStatsTableCreateCompanionBuilder,
          $$PokemonStatsTableUpdateCompanionBuilder,
          (PokemonStat, $$PokemonStatsTableReferences),
          PokemonStat,
          PrefetchHooks Function({bool pokemonId})
        > {
  $$PokemonStatsTableTableManager(_$AppDatabase db, $PokemonStatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> pokemonId = const Value.absent(),
                Value<String> statName = const Value.absent(),
                Value<int> baseStat = const Value.absent(),
              }) => PokemonStatsCompanion(
                id: id,
                pokemonId: pokemonId,
                statName: statName,
                baseStat: baseStat,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int pokemonId,
                required String statName,
                required int baseStat,
              }) => PokemonStatsCompanion.insert(
                id: id,
                pokemonId: pokemonId,
                statName: statName,
                baseStat: baseStat,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonStatsTable, PokemonStat>(table),
                  $$PokemonStatsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonStatsTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonStatsTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PokemonStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonStatsTable,
      PokemonStat,
      $$PokemonStatsTableFilterComposer,
      $$PokemonStatsTableOrderingComposer,
      $$PokemonStatsTableAnnotationComposer,
      $$PokemonStatsTableCreateCompanionBuilder,
      $$PokemonStatsTableUpdateCompanionBuilder,
      (PokemonStat, $$PokemonStatsTableReferences),
      PokemonStat,
      PrefetchHooks Function({bool pokemonId})
    >;
typedef $$PokemonAbilitiesTableCreateCompanionBuilder =
    PokemonAbilitiesCompanion Function({
      Value<int> id,
      required int pokemonId,
      required String abilityName,
      Value<bool> isHidden,
      Value<String?> shortEffect,
    });
typedef $$PokemonAbilitiesTableUpdateCompanionBuilder =
    PokemonAbilitiesCompanion Function({
      Value<int> id,
      Value<int> pokemonId,
      Value<String> abilityName,
      Value<bool> isHidden,
      Value<String?> shortEffect,
    });

final class $$PokemonAbilitiesTableReferences
    extends
        BaseReferences<_$AppDatabase, $PokemonAbilitiesTable, PokemonAbility> {
  $$PokemonAbilitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_abilities__pokemon_id__pokemons__id');

  $$PokemonsTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonAbilitiesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTable> {
  $$PokemonAbilitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abilityName => $composableBuilder(
    column: $table.abilityName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortEffect => $composableBuilder(
    column: $table.shortEffect,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonsTableFilterComposer get pokemonId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableFilterComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTable> {
  $$PokemonAbilitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abilityName => $composableBuilder(
    column: $table.abilityName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortEffect => $composableBuilder(
    column: $table.shortEffect,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonsTableOrderingComposer get pokemonId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableOrderingComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTable> {
  $$PokemonAbilitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get abilityName => $composableBuilder(
    column: $table.abilityName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);

  GeneratedColumn<String> get shortEffect => $composableBuilder(
    column: $table.shortEffect,
    builder: (column) => column,
  );

  $$PokemonsTableAnnotationComposer get pokemonId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonAbilitiesTable,
          PokemonAbility,
          $$PokemonAbilitiesTableFilterComposer,
          $$PokemonAbilitiesTableOrderingComposer,
          $$PokemonAbilitiesTableAnnotationComposer,
          $$PokemonAbilitiesTableCreateCompanionBuilder,
          $$PokemonAbilitiesTableUpdateCompanionBuilder,
          (PokemonAbility, $$PokemonAbilitiesTableReferences),
          PokemonAbility,
          PrefetchHooks Function({bool pokemonId})
        > {
  $$PokemonAbilitiesTableTableManager(
    _$AppDatabase db,
    $PokemonAbilitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonAbilitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonAbilitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonAbilitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> pokemonId = const Value.absent(),
                Value<String> abilityName = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
                Value<String?> shortEffect = const Value.absent(),
              }) => PokemonAbilitiesCompanion(
                id: id,
                pokemonId: pokemonId,
                abilityName: abilityName,
                isHidden: isHidden,
                shortEffect: shortEffect,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int pokemonId,
                required String abilityName,
                Value<bool> isHidden = const Value.absent(),
                Value<String?> shortEffect = const Value.absent(),
              }) => PokemonAbilitiesCompanion.insert(
                id: id,
                pokemonId: pokemonId,
                abilityName: abilityName,
                isHidden: isHidden,
                shortEffect: shortEffect,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonAbilitiesTable, PokemonAbility>(table),
                  $$PokemonAbilitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonAbilitiesTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonAbilitiesTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PokemonAbilitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonAbilitiesTable,
      PokemonAbility,
      $$PokemonAbilitiesTableFilterComposer,
      $$PokemonAbilitiesTableOrderingComposer,
      $$PokemonAbilitiesTableAnnotationComposer,
      $$PokemonAbilitiesTableCreateCompanionBuilder,
      $$PokemonAbilitiesTableUpdateCompanionBuilder,
      (PokemonAbility, $$PokemonAbilitiesTableReferences),
      PokemonAbility,
      PrefetchHooks Function({bool pokemonId})
    >;
typedef $$PokemonMovesTableCreateCompanionBuilder =
    PokemonMovesCompanion Function({
      Value<int> id,
      required int pokemonId,
      required int moveId,
      required String moveName,
      required String typeName,
      Value<int?> power,
      Value<int?> accuracy,
      Value<int?> pp,
      Value<int> level,
      Value<String> learnMethod,
    });
typedef $$PokemonMovesTableUpdateCompanionBuilder =
    PokemonMovesCompanion Function({
      Value<int> id,
      Value<int> pokemonId,
      Value<int> moveId,
      Value<String> moveName,
      Value<String> typeName,
      Value<int?> power,
      Value<int?> accuracy,
      Value<int?> pp,
      Value<int> level,
      Value<String> learnMethod,
    });

final class $$PokemonMovesTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonMovesTable, PokemonMove> {
  $$PokemonMovesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_moves__pokemon_id__pokemons__id');

  $$PokemonsTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonMovesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonMovesTable> {
  $$PokemonMovesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moveId => $composableBuilder(
    column: $table.moveId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moveName => $composableBuilder(
    column: $table.moveName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeName => $composableBuilder(
    column: $table.typeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pp => $composableBuilder(
    column: $table.pp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get learnMethod => $composableBuilder(
    column: $table.learnMethod,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonsTableFilterComposer get pokemonId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableFilterComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonMovesTable> {
  $$PokemonMovesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moveId => $composableBuilder(
    column: $table.moveId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moveName => $composableBuilder(
    column: $table.moveName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeName => $composableBuilder(
    column: $table.typeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pp => $composableBuilder(
    column: $table.pp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get learnMethod => $composableBuilder(
    column: $table.learnMethod,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonsTableOrderingComposer get pokemonId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableOrderingComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonMovesTable> {
  $$PokemonMovesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get moveId =>
      $composableBuilder(column: $table.moveId, builder: (column) => column);

  GeneratedColumn<String> get moveName =>
      $composableBuilder(column: $table.moveName, builder: (column) => column);

  GeneratedColumn<String> get typeName =>
      $composableBuilder(column: $table.typeName, builder: (column) => column);

  GeneratedColumn<int> get power =>
      $composableBuilder(column: $table.power, builder: (column) => column);

  GeneratedColumn<int> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<int> get pp =>
      $composableBuilder(column: $table.pp, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get learnMethod => $composableBuilder(
    column: $table.learnMethod,
    builder: (column) => column,
  );

  $$PokemonsTableAnnotationComposer get pokemonId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonMovesTable,
          PokemonMove,
          $$PokemonMovesTableFilterComposer,
          $$PokemonMovesTableOrderingComposer,
          $$PokemonMovesTableAnnotationComposer,
          $$PokemonMovesTableCreateCompanionBuilder,
          $$PokemonMovesTableUpdateCompanionBuilder,
          (PokemonMove, $$PokemonMovesTableReferences),
          PokemonMove,
          PrefetchHooks Function({bool pokemonId})
        > {
  $$PokemonMovesTableTableManager(_$AppDatabase db, $PokemonMovesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonMovesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonMovesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonMovesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> pokemonId = const Value.absent(),
                Value<int> moveId = const Value.absent(),
                Value<String> moveName = const Value.absent(),
                Value<String> typeName = const Value.absent(),
                Value<int?> power = const Value.absent(),
                Value<int?> accuracy = const Value.absent(),
                Value<int?> pp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<String> learnMethod = const Value.absent(),
              }) => PokemonMovesCompanion(
                id: id,
                pokemonId: pokemonId,
                moveId: moveId,
                moveName: moveName,
                typeName: typeName,
                power: power,
                accuracy: accuracy,
                pp: pp,
                level: level,
                learnMethod: learnMethod,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int pokemonId,
                required int moveId,
                required String moveName,
                required String typeName,
                Value<int?> power = const Value.absent(),
                Value<int?> accuracy = const Value.absent(),
                Value<int?> pp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<String> learnMethod = const Value.absent(),
              }) => PokemonMovesCompanion.insert(
                id: id,
                pokemonId: pokemonId,
                moveId: moveId,
                moveName: moveName,
                typeName: typeName,
                power: power,
                accuracy: accuracy,
                pp: pp,
                level: level,
                learnMethod: learnMethod,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonMovesTable, PokemonMove>(table),
                  $$PokemonMovesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonMovesTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonMovesTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PokemonMovesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonMovesTable,
      PokemonMove,
      $$PokemonMovesTableFilterComposer,
      $$PokemonMovesTableOrderingComposer,
      $$PokemonMovesTableAnnotationComposer,
      $$PokemonMovesTableCreateCompanionBuilder,
      $$PokemonMovesTableUpdateCompanionBuilder,
      (PokemonMove, $$PokemonMovesTableReferences),
      PokemonMove,
      PrefetchHooks Function({bool pokemonId})
    >;
typedef $$PokemonEvolutionsTableCreateCompanionBuilder =
    PokemonEvolutionsCompanion Function({
      Value<int> id,
      required int chainId,
      required int speciesId,
      required String speciesName,
      Value<int?> evolvesFromId,
      Value<String?> triggerName,
      Value<int?> minLevel,
    });
typedef $$PokemonEvolutionsTableUpdateCompanionBuilder =
    PokemonEvolutionsCompanion Function({
      Value<int> id,
      Value<int> chainId,
      Value<int> speciesId,
      Value<String> speciesName,
      Value<int?> evolvesFromId,
      Value<String?> triggerName,
      Value<int?> minLevel,
    });

class $$PokemonEvolutionsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonEvolutionsTable> {
  $$PokemonEvolutionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chainId => $composableBuilder(
    column: $table.chainId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get speciesName => $composableBuilder(
    column: $table.speciesName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get evolvesFromId => $composableBuilder(
    column: $table.evolvesFromId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get triggerName => $composableBuilder(
    column: $table.triggerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minLevel => $composableBuilder(
    column: $table.minLevel,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PokemonEvolutionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonEvolutionsTable> {
  $$PokemonEvolutionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chainId => $composableBuilder(
    column: $table.chainId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get speciesName => $composableBuilder(
    column: $table.speciesName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get evolvesFromId => $composableBuilder(
    column: $table.evolvesFromId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get triggerName => $composableBuilder(
    column: $table.triggerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minLevel => $composableBuilder(
    column: $table.minLevel,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonEvolutionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonEvolutionsTable> {
  $$PokemonEvolutionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get chainId =>
      $composableBuilder(column: $table.chainId, builder: (column) => column);

  GeneratedColumn<int> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<String> get speciesName => $composableBuilder(
    column: $table.speciesName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get evolvesFromId => $composableBuilder(
    column: $table.evolvesFromId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get triggerName => $composableBuilder(
    column: $table.triggerName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minLevel =>
      $composableBuilder(column: $table.minLevel, builder: (column) => column);
}

class $$PokemonEvolutionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonEvolutionsTable,
          PokemonEvolution,
          $$PokemonEvolutionsTableFilterComposer,
          $$PokemonEvolutionsTableOrderingComposer,
          $$PokemonEvolutionsTableAnnotationComposer,
          $$PokemonEvolutionsTableCreateCompanionBuilder,
          $$PokemonEvolutionsTableUpdateCompanionBuilder,
          (
            PokemonEvolution,
            BaseReferences<
              _$AppDatabase,
              $PokemonEvolutionsTable,
              PokemonEvolution
            >,
          ),
          PokemonEvolution,
          PrefetchHooks Function()
        > {
  $$PokemonEvolutionsTableTableManager(
    _$AppDatabase db,
    $PokemonEvolutionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonEvolutionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonEvolutionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonEvolutionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> chainId = const Value.absent(),
                Value<int> speciesId = const Value.absent(),
                Value<String> speciesName = const Value.absent(),
                Value<int?> evolvesFromId = const Value.absent(),
                Value<String?> triggerName = const Value.absent(),
                Value<int?> minLevel = const Value.absent(),
              }) => PokemonEvolutionsCompanion(
                id: id,
                chainId: chainId,
                speciesId: speciesId,
                speciesName: speciesName,
                evolvesFromId: evolvesFromId,
                triggerName: triggerName,
                minLevel: minLevel,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int chainId,
                required int speciesId,
                required String speciesName,
                Value<int?> evolvesFromId = const Value.absent(),
                Value<String?> triggerName = const Value.absent(),
                Value<int?> minLevel = const Value.absent(),
              }) => PokemonEvolutionsCompanion.insert(
                id: id,
                chainId: chainId,
                speciesId: speciesId,
                speciesName: speciesName,
                evolvesFromId: evolvesFromId,
                triggerName: triggerName,
                minLevel: minLevel,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonEvolutionsTable, PokemonEvolution>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PokemonEvolutionsTable,
                    PokemonEvolution
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PokemonEvolutionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonEvolutionsTable,
      PokemonEvolution,
      $$PokemonEvolutionsTableFilterComposer,
      $$PokemonEvolutionsTableOrderingComposer,
      $$PokemonEvolutionsTableAnnotationComposer,
      $$PokemonEvolutionsTableCreateCompanionBuilder,
      $$PokemonEvolutionsTableUpdateCompanionBuilder,
      (
        PokemonEvolution,
        BaseReferences<
          _$AppDatabase,
          $PokemonEvolutionsTable,
          PokemonEvolution
        >,
      ),
      PokemonEvolution,
      PrefetchHooks Function()
    >;
typedef $$FavoritesTableCreateCompanionBuilder = FavoritesCompanion Function({
  Value<int> pokemonId,
  Value<DateTime> addedAt,
});
typedef $$FavoritesTableUpdateCompanionBuilder = FavoritesCompanion Function({
  Value<int> pokemonId,
  Value<DateTime> addedAt,
});

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$FavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTable,
          Favorite,
          $$FavoritesTableFilterComposer,
          $$FavoritesTableOrderingComposer,
          $$FavoritesTableAnnotationComposer,
          $$FavoritesTableCreateCompanionBuilder,
          $$FavoritesTableUpdateCompanionBuilder,
          (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
          Favorite,
          PrefetchHooks Function()
        > {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> pokemonId = const Value.absent(),
            Value<DateTime> addedAt = const Value.absent(),
          }) => FavoritesCompanion(pokemonId: pokemonId, addedAt: addedAt),
          createCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
              }) => FavoritesCompanion.insert(
                pokemonId: pokemonId,
                addedAt: addedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavoritesTable, Favorite>(table),
                  BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTable,
      Favorite,
      $$FavoritesTableFilterComposer,
      $$FavoritesTableOrderingComposer,
      $$FavoritesTableAnnotationComposer,
      $$FavoritesTableCreateCompanionBuilder,
      $$FavoritesTableUpdateCompanionBuilder,
      (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
      Favorite,
      PrefetchHooks Function()
    >;
typedef $$TriviaRecordsTableCreateCompanionBuilder =
    TriviaRecordsCompanion Function({
      Value<int> id,
      required int score,
      required int correctAnswers,
      required int totalQuestions,
      Value<DateTime> playedAt,
    });
typedef $$TriviaRecordsTableUpdateCompanionBuilder =
    TriviaRecordsCompanion Function({
      Value<int> id,
      Value<int> score,
      Value<int> correctAnswers,
      Value<int> totalQuestions,
      Value<DateTime> playedAt,
    });

class $$TriviaRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $TriviaRecordsTable> {
  $$TriviaRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TriviaRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $TriviaRecordsTable> {
  $$TriviaRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TriviaRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TriviaRecordsTable> {
  $$TriviaRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);
}

class $$TriviaRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TriviaRecordsTable,
          TriviaRecord,
          $$TriviaRecordsTableFilterComposer,
          $$TriviaRecordsTableOrderingComposer,
          $$TriviaRecordsTableAnnotationComposer,
          $$TriviaRecordsTableCreateCompanionBuilder,
          $$TriviaRecordsTableUpdateCompanionBuilder,
          (
            TriviaRecord,
            BaseReferences<_$AppDatabase, $TriviaRecordsTable, TriviaRecord>,
          ),
          TriviaRecord,
          PrefetchHooks Function()
        > {
  $$TriviaRecordsTableTableManager(_$AppDatabase db, $TriviaRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TriviaRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TriviaRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TriviaRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> correctAnswers = const Value.absent(),
                Value<int> totalQuestions = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
              }) => TriviaRecordsCompanion(
                id: id,
                score: score,
                correctAnswers: correctAnswers,
                totalQuestions: totalQuestions,
                playedAt: playedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int score,
                required int correctAnswers,
                required int totalQuestions,
                Value<DateTime> playedAt = const Value.absent(),
              }) => TriviaRecordsCompanion.insert(
                id: id,
                score: score,
                correctAnswers: correctAnswers,
                totalQuestions: totalQuestions,
                playedAt: playedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TriviaRecordsTable, TriviaRecord>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TriviaRecordsTable,
                    TriviaRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TriviaRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TriviaRecordsTable,
      TriviaRecord,
      $$TriviaRecordsTableFilterComposer,
      $$TriviaRecordsTableOrderingComposer,
      $$TriviaRecordsTableAnnotationComposer,
      $$TriviaRecordsTableCreateCompanionBuilder,
      $$TriviaRecordsTableUpdateCompanionBuilder,
      (
        TriviaRecord,
        BaseReferences<_$AppDatabase, $TriviaRecordsTable, TriviaRecord>,
      ),
      TriviaRecord,
      PrefetchHooks Function()
    >;
typedef $$SyncMetadataTableCreateCompanionBuilder =
    SyncMetadataCompanion Function({
      required String key,
      required DateTime lastSyncTime,
      Value<int> totalRecords,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableUpdateCompanionBuilder =
    SyncMetadataCompanion Function({
      Value<String> key,
      Value<DateTime> lastSyncTime,
      Value<int> totalRecords,
      Value<int> rowid,
    });

class $$SyncMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalRecords => $composableBuilder(
    column: $table.totalRecords,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalRecords => $composableBuilder(
    column: $table.totalRecords,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalRecords => $composableBuilder(
    column: $table.totalRecords,
    builder: (column) => column,
  );
}

class $$SyncMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetadataTable,
          SyncMetadataData,
          $$SyncMetadataTableFilterComposer,
          $$SyncMetadataTableOrderingComposer,
          $$SyncMetadataTableAnnotationComposer,
          $$SyncMetadataTableCreateCompanionBuilder,
          $$SyncMetadataTableUpdateCompanionBuilder,
          (
            SyncMetadataData,
            BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>,
          ),
          SyncMetadataData,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableManager(_$AppDatabase db, $SyncMetadataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<DateTime> lastSyncTime = const Value.absent(),
                Value<int> totalRecords = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion(
                key: key,
                lastSyncTime: lastSyncTime,
                totalRecords: totalRecords,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required DateTime lastSyncTime,
                Value<int> totalRecords = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion.insert(
                key: key,
                lastSyncTime: lastSyncTime,
                totalRecords: totalRecords,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncMetadataTable, SyncMetadataData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncMetadataTable,
                    SyncMetadataData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetadataTable,
      SyncMetadataData,
      $$SyncMetadataTableFilterComposer,
      $$SyncMetadataTableOrderingComposer,
      $$SyncMetadataTableAnnotationComposer,
      $$SyncMetadataTableCreateCompanionBuilder,
      $$SyncMetadataTableUpdateCompanionBuilder,
      (
        SyncMetadataData,
        BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>,
      ),
      SyncMetadataData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PokemonsTableTableManager get pokemons =>
      $$PokemonsTableTableManager(_db, _db.pokemons);
  $$PokemonTypesTableTableManager get pokemonTypes =>
      $$PokemonTypesTableTableManager(_db, _db.pokemonTypes);
  $$PokemonStatsTableTableManager get pokemonStats =>
      $$PokemonStatsTableTableManager(_db, _db.pokemonStats);
  $$PokemonAbilitiesTableTableManager get pokemonAbilities =>
      $$PokemonAbilitiesTableTableManager(_db, _db.pokemonAbilities);
  $$PokemonMovesTableTableManager get pokemonMoves =>
      $$PokemonMovesTableTableManager(_db, _db.pokemonMoves);
  $$PokemonEvolutionsTableTableManager get pokemonEvolutions =>
      $$PokemonEvolutionsTableTableManager(_db, _db.pokemonEvolutions);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
  $$TriviaRecordsTableTableManager get triviaRecords =>
      $$TriviaRecordsTableTableManager(_db, _db.triviaRecords);
  $$SyncMetadataTableTableManager get syncMetadata =>
      $$SyncMetadataTableTableManager(_db, _db.syncMetadata);
}
