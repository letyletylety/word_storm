import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DataClassName('Word')
class Words extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().unique().withLength(min: 1, max: 32)();
  IntColumn get diff => integer().named('difficulty')();
}

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
}

// join table
class WordCategories extends Table {
  IntColumn get wordId => integer().references(Words, #id)();
  IntColumn get categoryId => integer().references(Categories, #id)();

  @override
  Set<Column> get primaryKey => {wordId, categoryId};
}

@DriftDatabase(tables: [Words, Categories, WordCategories])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);
  @override
  int get schemaVersion => 1;

  // 단어 제목으로 Word 엔티티를 찾는 함수
  Future<Word?> findWordByTitle(String title) {
    return (select(
      words,
    )..where((tbl) => tbl.title.equals(title))).getSingleOrNull();
  }

  // 카테고리 이름으로 Category 엔티티를 찾는 함수
  Future<Category?> findCategoryByName(String name) {
    return (select(
      categories,
    )..where((tbl) => tbl.name.equals(name))).getSingleOrNull();
  }

  static QueryExecutor openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
