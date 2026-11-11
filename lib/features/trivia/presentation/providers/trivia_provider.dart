import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/daos/trivia_dao.dart';
import '../../../../core/providers.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

enum TriviaStatus { notStarted, playing, answered, finished, notEnoughData }

class TriviaAchievement {
  final String id;
  final String titleEs;
  final String titleEn;
  final String descEs;
  final String descEn;
  final String icon;
  final bool isUnlocked;

  const TriviaAchievement({
    required this.id,
    required this.titleEs,
    required this.titleEn,
    required this.descEs,
    required this.descEn,
    required this.icon,
    this.isUnlocked = false,
  });

  TriviaAchievement copyWith({bool? isUnlocked}) {
    return TriviaAchievement(
      id: id,
      titleEs: titleEs,
      titleEn: titleEn,
      descEs: descEs,
      descEn: descEn,
      icon: icon,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}

class TriviaGameState {
  final TriviaStatus status;
  final int currentQuestion;
  final int totalQuestions;
  final int score;
  final int correctAnswers;
  final int secondsRemaining;
  final PokemonListItem? targetPokemon;
  final List<PokemonListItem> currentOptions;
  final String? selectedAnswer;
  final bool isEnglish;
  final List<TriviaAchievement> achievements;

  const TriviaGameState({
    this.status = TriviaStatus.notStarted,
    this.currentQuestion = 0,
    this.totalQuestions = 5,
    this.score = 0,
    this.correctAnswers = 0,
    this.secondsRemaining = 15,
    this.targetPokemon,
    this.currentOptions = const [],
    this.selectedAnswer,
    this.isEnglish = false,
    this.achievements = const [
      TriviaAchievement(
        id: 'first_catch',
        titleEs: 'Primer Acierto',
        titleEn: 'First Catch',
        descEs: 'Acierta tu primera pregunta en la trivia.',
        descEn: 'Answer your first question correctly.',
        icon: '🎯',
      ),
      TriviaAchievement(
        id: 'expert_trainer',
        titleEs: 'Entrenador Experto',
        titleEn: 'Expert Trainer',
        descEs: 'Acierta 3 o más preguntas en una sola partida.',
        descEn: 'Score 3 or more correct answers in a game.',
        icon: '🏆',
      ),
      TriviaAchievement(
        id: 'pokemon_master',
        titleEs: 'Maestro Pokémon',
        titleEn: 'Pokémon Master',
        descEs: 'Logra una partida perfecta (5/5 aciertos).',
        descEn: 'Achieve a perfect 5/5 score.',
        icon: '👑',
      ),
    ],
  });

  TriviaGameState copyWith({
    TriviaStatus? status,
    int? currentQuestion,
    int? totalQuestions,
    int? score,
    int? correctAnswers,
    int? secondsRemaining,
    PokemonListItem? targetPokemon,
    List<PokemonListItem>? currentOptions,
    String? selectedAnswer,
    bool? isEnglish,
    List<TriviaAchievement>? achievements,
  }) {
    return TriviaGameState(
      status: status ?? this.status,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      score: score ?? this.score,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      targetPokemon: targetPokemon ?? this.targetPokemon,
      currentOptions: currentOptions ?? this.currentOptions,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      isEnglish: isEnglish ?? this.isEnglish,
      achievements: achievements ?? this.achievements,
    );
  }
}

class TriviaGameNotifier extends Notifier<TriviaGameState> {
  Timer? _questionTimer;
  List<PokemonListItem> _availablePokemons = [];
  final Random _random = Random();

  @override
  TriviaGameState build() {
    ref.onDispose(() {
      _questionTimer?.cancel();
    });
    return const TriviaGameState();
  }

  void toggleLanguage() {
    state = state.copyWith(isEnglish: !state.isEnglish);
  }

  /// Inicia una nueva partida verificando el umbral de datos locales (RF-TRV-05)
  Future<void> startGame() async {
    _questionTimer?.cancel();

    // Consultamos los Pokémon disponibles localmente en SQLite
    final repo = ref.read(pokemonRepositoryProvider);
    _availablePokemons = await repo.getPokemonsForTrivia(limit: 50);

    // Umbral definido: se requieren al menos 4 Pokémon para generar opciones
    if (_availablePokemons.length < 4) {
      state = state.copyWith(status: TriviaStatus.notEnoughData);
      return;
    }

    state = state.copyWith(
      status: TriviaStatus.playing,
      currentQuestion: 1,
      score: 0,
      correctAnswers: 0,
      selectedAnswer: null,
    );

    _generateQuestion();
  }

  void _generateQuestion() {
    _questionTimer?.cancel();

    if (_availablePokemons.length < 4) return;

    // Seleccionar 4 Pokémon aleatorios
    final shuffled = List<PokemonListItem>.from(_availablePokemons)..shuffle(_random);
    final selectedOptions = shuffled.take(4).toList();
    final target = selectedOptions[_random.nextInt(4)];

    state = state.copyWith(
      status: TriviaStatus.playing,
      targetPokemon: target,
      currentOptions: selectedOptions,
      selectedAnswer: null,
      secondsRemaining: 15, // 15 segundos por pregunta (RF-TRV-02)
    );

    // Temporizador de 1 segundo
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 1) {
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      } else {
        // Se acabó el tiempo
        timer.cancel();
        _handleAnswer(null); // Sin respuesta a tiempo
      }
    });
  }

  void selectAnswer(String pokemonName) {
    if (state.status != TriviaStatus.playing) return;
    _questionTimer?.cancel();
    _handleAnswer(pokemonName);
  }

  void _handleAnswer(String? answer) async {
    final isCorrect = answer != null &&
        state.targetPokemon != null &&
        answer.toLowerCase() == state.targetPokemon!.name.toLowerCase();

    // Puntos: 100 puntos base + bonificación por tiempo restante (hasta 150 pts)
    final pointsEarned = isCorrect ? (100 + state.secondsRemaining * 5) : 0;
    final newScore = state.score + pointsEarned;
    final newCorrect = isCorrect ? state.correctAnswers + 1 : state.correctAnswers;

    state = state.copyWith(
      status: TriviaStatus.answered,
      selectedAnswer: answer ?? '',
      score: newScore,
      correctAnswers: newCorrect,
    );

    // Esperar 2 segundos para mostrar la silueta a color y el resultado
    await Future.delayed(const Duration(milliseconds: 2200));

    if (state.currentQuestion < state.totalQuestions) {
      state = state.copyWith(currentQuestion: state.currentQuestion + 1);
      _generateQuestion();
    } else {
      _finishGame();
    }
  }

  void _finishGame() async {
    _questionTimer?.cancel();

    // Desbloquear logros según umbrales (RF-TRV-04)
    final updatedAchievements = state.achievements.map((a) {
      if (a.id == 'first_catch' && state.correctAnswers >= 1) {
        return a.copyWith(isUnlocked: true);
      }
      if (a.id == 'expert_trainer' && state.correctAnswers >= 3) {
        return a.copyWith(isUnlocked: true);
      }
      if (a.id == 'pokemon_master' && state.correctAnswers == state.totalQuestions) {
        return a.copyWith(isUnlocked: true);
      }
      return a;
    }).toList();

    state = state.copyWith(
      status: TriviaStatus.finished,
      achievements: updatedAchievements,
    );

    // Guardar en SQLite el ranking local (RF-TRV-03)
    await ref.read(triviaRepositoryProvider).saveRecord(
          score: state.score,
          correctAnswers: state.correctAnswers,
          totalQuestions: state.totalQuestions,
        );
  }
}

final triviaGameProvider =
    NotifierProvider<TriviaGameNotifier, TriviaGameState>(() {
  return TriviaGameNotifier();
});

/// Stream del Ranking local persistido en SQLite (RF-TRV-03)
final triviaLeaderboardStreamProvider =
    StreamProvider<List<TriviaScoreEntity>>((ref) {
  final repo = ref.watch(triviaRepositoryProvider);
  return repo.watchLeaderboard();
});
