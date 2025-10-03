import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:word_storm_drift/database/database.dart';

final dbName = 'word_game.db';
final outputDirectory = Directory('wordset/output');

String databasePath() => p.join(outputDirectory.path, dbName);

Future<AppDatabase> getDatabase() async {
  final dbPath = databasePath();

  if (await File(dbPath).exists()) {
    print('기존 데이터베이스 파일을 삭제합니다.');
    await File(dbPath).delete();
  }

  print('db 파일 생성을 시작합니다.');
  final file = await File(dbPath).create();

  // 1. 데이터베이스 파일 생성 및 테이블 정의
  final db = AppDatabase(NativeDatabase(file));
  return db;
}

Future<void> putDataIntoDB(AppDatabase db, List<String> csvLines) async {
  try {
    if (csvLines.isNotEmpty) {
      csvLines.removeAt(0);
    }

    await db.transaction(() async {
      for (var csvline in csvLines) {
        final line = csvline.trim();
        if (line.isEmpty) continue;

        final parts = line.split(',');
        if (parts.length == 3) {
          final titleText = parts[0];
          final categoryName = parts[1];
          final difficulty = int.tryParse(parts[2]) ?? 1;

          // 1. 카테고리 존재 여부 확인
          Category? category = await db.findCategoryByName(categoryName);

          if (category == null) {
            // 카테고리가 없으면 새로 삽입하고 ID를 가져옴
            final newId = await db
                .into(db.categories)
                .insert(
                  CategoriesCompanion.insert(name: categoryName),
                  mode: InsertMode.insert,
                );
            category = Category(id: newId, name: categoryName);
          }

          // 2. 단어 존재 여부 확인
          Word? word = await db.findWordByTitle(titleText);

          if (word == null) {
            // `id`는 auto-increment이므로 insertOrUpdate에서 사용하지 않습니다.
            final newId = await db
                .into(db.words)
                .insert(
                  WordsCompanion.insert(title: titleText, diff: difficulty),
                );
            word = Word(id: newId, title: titleText, diff: difficulty);
          } else {
            // 단어가 이미 존재하면 난이도 업데이트
            await (db.update(db.words)..where((tbl) => tbl.id.equals(word!.id)))
                .write(WordsCompanion(diff: Value(difficulty)));
          }

          // 3. WordCategories 테이블에 조인 정보 추가 (단어-카테고리 연결)
          // TODO :
          // db.select(db.words).where((w) => w.title.equals());

          // 3. 단어-카테고리 연결 존재 여부 확인 및 삽입
          final existingJoin =
              await (db.select(db.wordCategories)..where(
                    (tbl) =>
                        tbl.wordId.equals(word!.id) &
                        tbl.categoryId.equals(category!.id),
                  ))
                  .getSingleOrNull();

          if (existingJoin == null) {
            await db
                .into(db.wordCategories)
                .insert(
                  WordCategoriesCompanion.insert(
                    wordId: word.id,
                    categoryId: category.id,
                  ),
                );
          }
        }
      }
    });

    print('성공적으로 데이터베이스 파일이 생성되었습니다: $dbName');
  } catch (e) {
    print('오류가 발생했습니다: $e');
  }
}
