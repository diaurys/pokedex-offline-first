import '../../domain/repositories/trivia_repository.dart';
import '../../../../core/database/daos/trivia_dao.dart';

class TriviaRepositoryImpl implements TriviaRepository {
  final TriviaDao _triviaDao;

  TriviaRepositoryImpl(this._triviaDao);

  @override
  Future<int> saveRecord({
    required int score,
    required int correctAnswers,
    required int totalQuestions,
  }) {
    return _triviaDao.saveRecord(
      score: score,
      correctAnswers: correctAnswers,
      totalQuestions: totalQuestions,
    );
  }

  @override
  Stream<List<TriviaScoreEntity>> watchLeaderboard({int limit = 10}) {
    return _triviaDao.watchLeaderboard(limit: limit);
  }

  @override
  Future<int> getBestScore() {
    return _triviaDao.getBestScore();
  }
}
