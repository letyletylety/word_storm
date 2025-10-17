import 'dart:convert';
import 'dart:io';

import 'package:app/data/repository/word_repository.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:word_storm_drift/csv_2_db.dart';
import 'package:word_storm_drift/database/database.dart';

// 테스트에 사용할 CSV 데이터:
// 1. 단어: '사자', '호랑이', '곰'
// 2. 고유 글자: '사', '자', '호', '랑', '이', '곰' (총 6개)
const String testCsvData = '''
title,category,difficulty
사자,동물,1
호랑이,동물,1
곰,동물,1
''';

void main() {
  group('WordRepository', () {
    late AppDatabase database;
    late WordRepository wordRepository;
    final dir = Directory.current;
    final file = File(p.join(dir.path, 'test_assets', 'words.csv'));

    setUp(() async {
      database = await getTestAppDatabase();
      wordRepository = WordRepository(database);
    });

    tearDown(() async {
      await database.close();
      final file = await getTestDbFile();
      await file.delete();
    });
    test('1231', () async {
      final List<Word> a = await wordRepository.getWordsByCategory('동물');

      a.forEach((w) => print('$w,'));

      expect(a.isNotEmpty, true);
    });
  });

  group('repository test', () {
    late WordRepository repository;
    late AppDatabase database;

    setUpAll(() {
      final file = File(
        p.join(Directory.current.path, 'assets', 'data', 'words.csv'),
      );
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
      file.writeAsStringSync(testCsvData);
    });

    setUp(() async {
      // 메모리 데이터베이스 초기화 및 데이터 채우기
      database = AppDatabase(NativeDatabase.memory());
      repository = WordRepository(database);
      await putDataIntoDB(
        database,
        testCsvData.split('\n'),
      ); // 테스트 CSV 데이터로 DB 채우기
    });

    tearDown(() async {
      await database.close();
    });
    // --- getAllUniqueLetters 테스트 ---
    test('getAllUniqueLetters는 DB의 모든 단어에서 고유 글자를 중복 없이 가져와야 한다', () async {
      final allUniqueLetters = await repository.getAllUniqueLetters();

      // 1. 글자 개수 확인
      // '사', '자', '호', '랑', '이', '곰' => 6개
      expect(allUniqueLetters.length, 6, reason: '모든 단어에서 6개의 고유 글자를 가져와야 함');

      // 2. 글자 내용 확인
      const expectedLetters = {'사', '자', '호', '랑', '이', '곰'};
      expect(allUniqueLetters, expectedLetters, reason: '가져온 글자 목록이 정확해야 함');
    });

    // --- 추가 검증: 중복된 글자가 실제로 제거되는지 확인 ---
    test('중복된 글자가 있는 경우에도 Set 연산을 통해 정확히 필터링되어야 한다', () async {
      // CSV 데이터에 '개미'와 '미아'를 추가로 삽입한다고 가정
      // '개', '미', '아'가 추가됨.
      await database
          .into(database.words)
          .insert(WordsCompanion.insert(title: '개미', diff: 1));
      await database
          .into(database.words)
          .insert(WordsCompanion.insert(title: '미아', diff: 1));

      final updatedUniqueLetters = await repository.getAllUniqueLetters();

      // 이전 6개 ('사', '자', '호', '랑', '이', '곰') + '개', '미', '아' (3개) = 9개
      expect(
        updatedUniqueLetters.length,
        9,
        reason: '새 단어의 고유 글자 3개가 추가되어 총 9개가 되어야 함',
      );
      expect(
        updatedUniqueLetters,
        containsAll({'개', '미', '아'}),
        reason: '새 글자들을 포함해야 함',
      );
    });
  });
}

Future<File> getTestDbFile() async {
  final directory = Directory(
    p.join(Directory.current.path, 'test', 'test_assets', 'word_game.db'),
  );
  final testDbFile = File(directory.path);

  // 3. 기존 DB 파일이 있다면 삭제 (테스트 간 간섭 방지)
  // if (await testDbFile.exists()) {
  //   await testDbFile.delete();
  // }

  return testDbFile;
}

Future<AppDatabase> getTestAppDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 1. Flutter 테스트 환경에서 Asset 로드를 활성화합니다.
  final testDbFile = await getTestDbFile();

  // 4. Assets에서 미리 만들어둔 DB 파일 로드 및 복사 (핵심!)
  // 이 경로는 당신의 main Flutter 프로젝트 assets 경로를 따라야 합니다.
  final ByteData data = await rootBundle.load('assets/word_game.db');
  final List<int> bytes = data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  );
  await testDbFile.writeAsBytes(bytes, flush: true);

  return AppDatabase(NativeDatabase(testDbFile));
}
