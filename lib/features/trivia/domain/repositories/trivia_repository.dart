import '../../../../core/database/daos/trivia_dao.dart';

abstract class TriviaRepository {
  Future<int> saveRecord({
    required int score,
    required int correctAnswers,
    required int totalQuestions,
  });

  Stream<List<TriviaScoreEntity>> watchLeaderboard({int limit = 10});
  Future<int> getBestScore();
}
