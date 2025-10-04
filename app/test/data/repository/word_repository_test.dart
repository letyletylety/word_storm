import 'dart:io';
import 'dart:typed_data';

import 'package:app/data/repository/word_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:word_storm_drift/database/database.dart';

void main() {
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

  group('WordRepository', () {
    test('1231', () async {
      final List<Word> a = await wordRepository.getWordsByCategory('동물');

      a.forEach((w) => print('$w,'));

      expect(a.isNotEmpty, true);
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
