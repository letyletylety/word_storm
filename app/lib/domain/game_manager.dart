import 'package:app/data/repository/word_repository.dart';
import 'package:app/data/services/puzzle_maker/puzzle_board_factory.dart';
import 'package:flutter/widgets.dart';
import 'package:word_storm_drift/database/database.dart';

class GameManager extends ChangeNotifier {
  final WordRepository repository;
  late PuzzleBoardFactory puzzleBoardFactory;

  /// 캐시 및 준비 상태
  late Set<String> _allLettersCache;

  /// 모든 카테고리 목록
  late List<Category> _allCategories;

  /// 데이터 로드 완료 상태
  bool _isDataReady = false;

  GameManager(this.repository);

  Future puzzleMaker() async {
    List<Word> wordsByCategory = await repository.getWordsByCategory('동물');
    return await puzzleBoardFactory.createNewBoard(wordsByCategory);
  }

  initializeGameAsset() async {
    _allLettersCache = await repository.getAllUniqueLetters();
    _allCategories = await repository.getAllCategories();
  }
}
