import 'package:app/data/services/puzzle_maker/models.dart';
import 'package:word_storm_drift/database/database.dart';

class PuzzleBoardFactory {
  final int gridSize = 64;

  Future<PuzzleBoard> createNewBoard(List<Word> possibleWords) async {
    // 정답에 쓰일 단어들

    final answerWords = await getAnswerWords(possibleWords);

    return PuzzleBoard();
  }

  getAnswerWords(List<Word> wordsList) {
    final double answerRatio = 0.75;
    final int answerCount = (gridSize * answerRatio).round();
  }
}
