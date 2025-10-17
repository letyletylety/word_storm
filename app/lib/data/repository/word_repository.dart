import 'package:drift/drift.dart';
import 'package:word_storm_drift/database/database.dart';

class WordRepository {
  WordRepository(this._db);

  final AppDatabase _db;

  AppDatabase get db => _db;

  /// ([bool] : is it success?)
  Future<(Category?, bool)> getCategories() async {
    final categoriesList = await db.select(db.categories).get();
    if (categoriesList.isEmpty) {
      return (null, false);
    }
    return (categoriesList.first, true);
  }

  Future<List<Category>> getAllCategories() async {
    final categoriesList = await db.select(db.categories).get();
    return categoriesList;
  }

  // 2. 특정 카테고리에 속하는 모든 단어를 가져옵니다. (핵심 쿼리)
  Future<List<Word>> getWordsByCategory(String categoryName) async {
    // 이 쿼리는 이전에 설계했던 조인(JOIN) 로직을 사용합니다.
    final query =
        db.select(db.words).join([
            innerJoin(
              db.wordCategories,
              db.wordCategories.wordId.equalsExp(db.words.id),
            ),
            innerJoin(
              db.categories,
              db.categories.id.equalsExp(db.wordCategories.categoryId),
            ),
          ])
          // 카테고리 이름으로 필터링합니다.
          ..where(db.categories.name.equals(categoryName));

    // 결과에서 Word 엔티티만 추출하여 반환합니다.
    return query.map((row) => row.readTable(db.words)).get();
  }

  Future<Set<String>> getAllUniqueLetters() async {
    // DB의 모든 단어를 가져옵니다.
    final allWords = await db.select(db.words).get();

    // Set을 사용하여 중복 없이 모든 글자를 수집합니다.
    final Set<String> allUniqueLetters = allWords
        .expand((word) => word.title.split('')) // 단어를 글자로 분해
        .toSet();

    return allUniqueLetters;
  }
}

class CategoryNotFoundError implements Exception {}
