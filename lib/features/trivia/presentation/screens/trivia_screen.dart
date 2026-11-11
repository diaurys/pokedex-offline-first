import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers.dart';
import '../providers/trivia_provider.dart';

/// Pantalla interactiva del juego de Trivia (RF-TRV-01 a RF-TRV-06)
class TriviaScreen extends ConsumerWidget {
  const TriviaScreen({super.key});

  void _showLeaderboardAndAchievements(BuildContext context, WidgetRef ref) {
    final gameState = ref.read(triviaGameProvider);
    final isEn = gameState.isEnglish;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DefaultTabController(
          length: 2,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: AppColors.primaryRed,
                  labelColor: AppColors.primaryRed,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    Tab(
                      icon: const Icon(Icons.leaderboard),
                      text: isEn ? 'Leaderboard' : 'Ranking Local',
                    ),
                    Tab(
                      icon: const Icon(Icons.emoji_events),
                      text: isEn ? 'Achievements' : 'Logros',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Tab 1: Ranking Local (RF-TRV-03)
                      Consumer(
                        builder: (context, ref, _) {
                          final boardAsync =
                              ref.watch(triviaLeaderboardStreamProvider);
                          return boardAsync.when(
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (e, _) => Center(child: Text('Error: $e')),
                            data: (records) {
                              if (records.isEmpty) {
                                return Center(
                                  child: Text(
                                    isEn
                                        ? 'No games played yet. Play a round!'
                                        : 'Aún no hay partidas jugadas. ¡Juega una ronda!',
                                    style:
                                        const TextStyle(color: Colors.black54),
                                  ),
                                );
                              }
                              return ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: records.length,
                                itemBuilder: (context, index) {
                                  final r = records[index];
                                  final dateStr =
                                      DateFormat('dd/MM/yyyy HH:mm')
                                          .format(r.playedAt);
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: index == 0
                                          ? AppColors.pokeYellow
                                          : index == 1
                                              ? Colors.grey.shade400
                                              : index == 2
                                                  ? Colors.brown.shade300
                                                  : Colors.grey.shade200,
                                      foregroundColor: index < 3
                                          ? Colors.black87
                                          : Colors.black54,
                                      child: Text('#${index + 1}'),
                                    ),
                                    title: Text(
                                      '${r.score} ${isEn ? "points" : "puntos"}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      '${r.correctAnswers}/${r.totalQuestions} ${isEn ? "correct" : "aciertos"} · $dateStr',
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),

                      // Tab 2: Logros Desbloqueados (RF-TRV-04)
                      Consumer(
                        builder: (context, ref, _) {
                          final achievements =
                              ref.watch(triviaGameProvider).achievements;
                          return ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: achievements.length,
                            itemBuilder: (context, index) {
                              final a = achievements[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                elevation: a.isUnlocked ? 2 : 0,
                                color: a.isUnlocked
                                    ? Colors.amber.shade50
                                    : Colors.grey.shade100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  side: BorderSide(
                                    color: a.isUnlocked
                                        ? Colors.amber
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: ListTile(
                                  leading: Text(
                                    a.icon,
                                    style: TextStyle(
                                      fontSize: 32,
                                      color: a.isUnlocked ? null : Colors.grey,
                                    ),
                                  ),
                                  title: Text(
                                    isEn ? a.titleEn : a.titleEs,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: a.isUnlocked
                                          ? Colors.black87
                                          : Colors.grey,
                                    ),
                                  ),
                                  subtitle: Text(
                                    isEn ? a.descEn : a.descEs,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: a.isUnlocked
                                          ? Colors.black54
                                          : Colors.grey,
                                    ),
                                  ),
                                  trailing: Icon(
                                    a.isUnlocked
                                        ? Icons.check_circle
                                        : Icons.lock,
                                    color: a.isUnlocked
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(triviaGameProvider);
    final notifier = ref.read(triviaGameProvider.notifier);
    final isEn = gameState.isEnglish;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: Text(
          isEn ? 'Pokémon Trivia' : 'Trivia Pokémon',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        actions: [
          // Selector de Idioma Español / Inglés (RF-TRV-06)
          TextButton(
            onPressed: notifier.toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isEn ? '🇺🇸 EN' : '🇪🇸 ES',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Botón Ver Ranking y Logros (RF-TRV-03, RF-TRV-04)
          IconButton(
            icon: const Icon(Icons.emoji_events),
            tooltip: isEn ? 'Leaderboard & Achievements' : 'Ranking y Logros',
            onPressed: () => _showLeaderboardAndAchievements(context, ref),
          ),
        ],
      ),
      body: _buildBody(context, ref, gameState, notifier, isEn),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    TriviaGameState gameState,
    TriviaGameNotifier notifier,
    bool isEn,
  ) {
    switch (gameState.status) {
      case TriviaStatus.notStarted:
        return _buildStartScreen(context, notifier, isEn);

      case TriviaStatus.notEnoughData:
        return _buildNotEnoughDataScreen(context, ref, isEn);

      case TriviaStatus.playing:
      case TriviaStatus.answered:
        return _buildQuestionScreen(context, gameState, notifier, isEn);

      case TriviaStatus.finished:
        return _buildFinishedScreen(context, gameState, notifier, isEn);
    }
  }

  // --- Pantalla de Inicio ---
  Widget _buildStartScreen(
      BuildContext context, TriviaGameNotifier notifier, bool isEn) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryRed.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.catching_pokemon,
                size: 90,
                color: AppColors.primaryRed,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isEn ? "Who's that Pokémon?" : '¿Quién es este Pokémon?',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isEn
                  ? 'Identify 5 Pokémon by their silhouettes. You have 15 seconds per question. Points are awarded for speed and accuracy!'
                  : 'Adivina 5 Pokémon por su silueta. Tienes 15 segundos por pregunta. ¡Gana puntos extra por responder rápido!',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: Text(
                  isEn ? 'Start Trivia' : 'Iniciar Trivia',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: notifier.startGame,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Pantalla de datos insuficientes (RF-TRV-05) ---
  Widget _buildNotEnoughDataScreen(
      BuildContext context, WidgetRef ref, bool isEn) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off,
              size: 80,
              color: AppColors.statusServiceUnavailable,
            ),
            const SizedBox(height: 20),
            Text(
              isEn ? 'Not Enough Local Data' : 'Datos Locales Insuficientes',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              isEn
                  ? 'At least 4 Pokémon must be stored locally in SQLite to play the trivia offline. Please synchronize the catalog first.'
                  : 'Se necesitan al menos 4 Pokémon descargados en la base de datos local SQLite para jugar la trivia. Sincroniza el catálogo primero.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.sync),
              label: Text(isEn ? 'Sync Catalog Now' : 'Sincronizar Catálogo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRed,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ref.read(syncCoordinatorProvider).syncCatalog(force: true);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Pantalla de Pregunta Activa (RF-TRV-01, RF-TRV-02) ---
  Widget _buildQuestionScreen(
    BuildContext context,
    TriviaGameState state,
    TriviaGameNotifier notifier,
    bool isEn,
  ) {
    final target = state.targetPokemon;
    if (target == null) return const SizedBox.shrink();

    final isAnswered = state.status == TriviaStatus.answered;
    final timePercent = state.secondsRemaining / 15.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Barra de información superior (Pregunta X/5, Tiempo y Puntos)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${isEn ? "Question" : "Pregunta"} ${state.currentQuestion}/${state.totalQuestions}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryRed.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${state.score} pts',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryRed,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Barra de progreso del tiempo restante (RF-TRV-02)
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: timePercent,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                state.secondsRemaining <= 4
                    ? Colors.red
                    : state.secondsRemaining <= 8
                        ? Colors.orange
                        : AppColors.statusOnline,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${state.secondsRemaining}s',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: state.secondsRemaining <= 4 ? Colors.red : Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Silueta del Pokémon (RF-TRV-01) o imagen real si ya respondió
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: SizedBox(
                height: 170,
                width: 170,
                child: isAnswered
                    ? CachedNetworkImage(
                        imageUrl: target.officialArtwork,
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/pokeball_placeholder.png',
                          fit: BoxFit.contain,
                        ),
                      )
                    : ColorFiltered(
                        // Efecto silueta negra para "¿Quién es este Pokémon?" (RF-TRV-01)
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF212121),
                          BlendMode.srcIn,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: target.officialArtwork,
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/pokeball_placeholder.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 4 Opciones de respuesta (touch target >= 48x48 per RNF-ACC-03)
          ...state.currentOptions.map((opt) {
            final formattedOptName =
                opt.name[0].toUpperCase() + opt.name.substring(1);
            final isTarget =
                opt.name.toLowerCase() == target.name.toLowerCase();
            final isSelected = state.selectedAnswer?.toLowerCase() ==
                opt.name.toLowerCase();

            Color buttonBg = Colors.white;
            Color textColor = Colors.black87;
            BorderSide border = BorderSide(color: Colors.grey.shade300);

            if (isAnswered) {
              if (isTarget) {
                // Correcto: Verde
                buttonBg = Colors.green.shade100;
                textColor = Colors.green.shade900;
                border = BorderSide(color: Colors.green.shade700, width: 2);
              } else if (isSelected) {
                // Incorrecto seleccionado: Rojo
                buttonBg = Colors.red.shade100;
                textColor = Colors.red.shade900;
                border = BorderSide(color: Colors.red.shade700, width: 2);
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonBg,
                    foregroundColor: textColor,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: border,
                    ),
                  ),
                  onPressed: isAnswered
                      ? null
                      : () => notifier.selectAnswer(opt.name),
                  child: Text(
                    formattedOptName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // --- Pantalla de Partida Terminada (RF-TRV-03, RF-TRV-04) ---
  Widget _buildFinishedScreen(
    BuildContext context,
    TriviaGameState state,
    TriviaGameNotifier notifier,
    bool isEn,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.pokeYellow.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events,
                size: 80,
                color: Color(0xFFF57F17),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isEn ? 'Game Finished!' : '¡Partida Completada!',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              '${isEn ? "Final Score:" : "Puntuación Final:"} ${state.score} pts',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryRed,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${state.correctAnswers}/${state.totalQuestions} ${isEn ? "correct answers" : "respuestas correctas"}',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.replay),
                label: Text(
                  isEn ? 'Play Again' : 'Jugar Otra Ronda',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: notifier.startGame,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
