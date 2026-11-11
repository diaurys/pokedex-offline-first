import 'package:drift/drift.dart';
import '../app_database.dart';

class TriviaScoreEntity {
  final int id;
  final int score;
  final int correctAnswers;
  final int totalQuestions;
  final DateTime playedAt;

  const TriviaScoreEntity({
    required this.id,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.playedAt,
  });
}

class TriviaDao {
  final AppDatabase db;

  TriviaDao(this.db);

  /// Guarda una nueva partida de trivia localmente (RF-TRV)
  Future<int> saveRecord({
    required int score,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    return await db.into(db.triviaRecords).insert(
          TriviaRecordsCompanion(
            score: Value(score),
            correctAnswers: Value(correctAnswers),
            totalQuestions: Value(totalQuestions),
            playedAt: Value(DateTime.now()),
          ),
        );
  }

  /// Observa el historial de mejores puntuaciones (ranking local)
  Stream<List<TriviaScoreEntity>> watchLeaderboard({int limit = 10}) {
    final query = db.select(db.triviaRecords)
      ..orderBy([(r) => OrderingTerm(expression: r.score, mode: OrderingMode.desc)])
      ..limit(limit);

    return query.watch().map((rows) {
      return rows
          .map((r) => TriviaScoreEntity(
                id: r.id,
                score: r.score,
                correctAnswers: r.correctAnswers,
                totalQuestions: r.totalQuestions,
                playedAt: r.playedAt,
              ))
          .toList();
    });
  }

  Future<int> getBestScore() async {
    final records = await (db.select(db.triviaRecords)
          ..orderBy([(r) => OrderingTerm(expression: r.score, mode: OrderingMode.desc)])
          ..limit(1))
        .get();
    return records.isEmpty ? 0 : records.first.score;
  }
}
