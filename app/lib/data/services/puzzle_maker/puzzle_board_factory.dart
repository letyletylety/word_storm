import 'dart:math';

import 'package:app/data/services/puzzle_maker/models/puzzle_board.dart';
import 'package:word_storm_drift/database/database.dart';

class PuzzleBoardFactory {
  final Set<String> allLettersCache; // 모든 고유한 글자

  PuzzleBoardFactory({required this.allLettersCache});

  final int gridSize = 64;

  Future<PuzzleBoard> createNewBoard(List<Word> possibleWords) async {
    // 카테고리 선택

    // 정답에 쓰일 단어들
    final answerWords = await _getAnswerWords(possibleWords);

    // 격자 글자 생성

    return PuzzleBoard();
  }

  /// 정답 단어 목록 추출
  /// [wordsList] 에 들어가있는 단어의 총 길이는 answerCount를 넘는다는 전제
  List<Word> _getAnswerWords(List<Word> wordsList) {
    final double answerRatio = 0.75;
    final int answerCount = (gridSize * answerRatio).floor();
    final int dummyCount = gridSize - answerCount;

    List<Word> bucket = [];
    // bucket에 담긴 단어들의 음절 개수
    int bucketWordLengthSum = 0;

    final random = Random.secure();
    wordsList.shuffle(random);

    final wordIter = wordsList.iterator;

    // 아직 안채워졌으면 계속해서 채움
    while (bucketWordLengthSum < answerCount) {
      Word current = wordIter.current;
      bucket.add(current);
      final t = wordIter.current.title;
      bucketWordLengthSum += t.length;

      // move next
      wordIter.moveNext();
    }
    return bucket;
  }
}
