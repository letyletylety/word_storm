import 'package:app/data/repository/word_repository.dart';
import 'package:app/data/services/puzzle_maker/puzzle_board_factory.dart';
import 'package:word_storm_drift/database/database.dart';

class GameManager {
  final WordRepository repository;
  final PuzzleBoardFactory puzzleBoardFactory;

  GameManager(this.repository, this.puzzleBoardFactory);

  Future puzzleMaker() async {
    List<Word> wordsByCategory = await repository.getWordsByCategory('동물');
    return await puzzleBoardFactory.createNewBoard(wordsByCategory);
  }
}
