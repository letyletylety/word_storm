// test/data_processing_test.dart

import 'dart:convert';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:word_storm_drift/csv_2_db.dart';
import 'package:word_storm_drift/database/database.dart';

const String testCsvData = '''
title,category,difficulty
고양이,동물,1
강아지,동물,1
기린,동물,1
사자,동물,1
사자,맹수,2
호랑이,동물,1
호랑이,맹수,2
''';

void main() {
  late AppDatabase database;

  setUpAll(() {
    // 테스트 CSV 파일 생성
    final file = File(
      p.join(Directory.current.path, 'assets', 'data', 'words.csv'),
    );
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync(testCsvData);
  });

  setUp(() {
    // 각 테스트를 위해 메모리 데이터베이스 초기화
    database = AppDatabase(NativeDatabase.memory(setup: (database) {}));
  });

  tearDown(() async {
    // 각 테스트 후 데이터베이스 연결 닫기
    database.allTables.forEach(database.delete);
    await database.close();
  });

  test('CSV 데이터가 데이터베이스에 올바르게 삽입되는지 테스트', () async {
    // 1. 데이터베이스 생성 스크립트 실행
    // 이 함수는 CSV 파일을 읽어 데이터베이스를 채웁니다.
    final lines = LineSplitter().convert(testCsvData);
    await putDataIntoDB(database, lines);

    // 2. Words 테이블에 중복 없는 단어가 들어갔는지 확인
    final allWords = await database.select(database.words).get();
    print(allWords);
    expect(allWords.length, 5); // 고양이, 강아지, 기린, 사자, 호랑이

    // 3. Categories 테이블에 중복 없는 카테고리가 들어갔는지 확인
    final allCategories = await database.select(database.categories).get();
    print(allCategories);
    expect(allCategories.length, 2); // 동물, 맹수

    final g = await database.select(database.wordCategories).get();
    print(g);

    // 4. 사자 단어에 두 카테고리가 모두 연결되었는지 확인
    final lionWord = await (database.select(
      database.words,
    )..where((tbl) => tbl.title.equals('사자'))).getSingle();

    final lionCategories = await (database.select(
      database.wordCategories,
    )..where((tbl) => tbl.wordId.equals(lionWord.id))).get();

    print(lionCategories);
    expect(lionCategories.length, 2); // '사자'는 두 카테고리에 속해야 함

    // 5. 호랑이 단어도 두 카테고리에 연결되었는지 확인
    final tigerWord = await (database.select(
      database.words,
    )..where((tbl) => tbl.title.equals('호랑이'))).getSingle();

    final tigerCategories = await (database.select(
      database.wordCategories,
    )..where((tbl) => tbl.wordId.equals(tigerWord.id))).get();

    expect(tigerCategories.length, 2); // '호랑이'는 두 카테고리에 속해야 함

    // 6. 단어들의 난이도가 제대로 업데이트되었는지 확인
    final lionDifficulty =
        await (database.select(database.words)
              ..where((tbl) => tbl.title.equals('사자')))
            .map((row) => row.diff)
            .getSingle();

    expect(lionDifficulty, 2); // 사자의 최종 난이도는 2여야 함
  });
}

// generate_db.dart 스크립트의 main 함수를 재사용 가능하게 수정
