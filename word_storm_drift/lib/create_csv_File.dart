import 'dart:io';

import 'package:word_storm_drift/database/database.dart';

import 'category.dart' as category;
import 'package:path/path.dart' as p;

final List<List<String>> csvHeader = [
  ['text', 'category', 'difficulty'], // CSV 헤더
];

Future createAllWordsCSVFile() async {
  print('csv 파일을 생성합니다.');
  // CSV 파일에 기록할 데이터를 저장할 리스트를 만듭니다.

  final inputDirectory = Directory('wordset/raw');
  final outputDirectory = Directory('wordset/output');
  final outputFile = File(p.join(outputDirectory.path, 'all_words.csv'));

  final categoryFileDescList = category.categoryFile;

  try {
    // 1. 디렉터리 존재 여부 확인
    await checkFiles(inputDirectory, outputDirectory, outputFile);

    final Set<Word> wordSet = <Word>{};
    // 카테고리 지정
    for (final categoryFileDesc in categoryFileDescList) {
      final fileName = categoryFileDesc.rawFileName;
      final categoryFilePath = p.join(inputDirectory.path, fileName);
      final categoryFile = File(categoryFilePath);

      if (!await categoryFile.exists()) {
        print('카테고리 파일 찾을 수 없음');
        continue;
      }
      print('카테고리 파일 찾음 : ${categoryFile.path}');

      wordSet.addAll(
        await rawFileRead(categoryFile, categoryFileDesc.category),
      );
    }

    await writeCsvFile(outputFile, wordSet);
    print('파일 쓰기 완료');
  } catch (e) {
    print('오류가 발생했습니다: $e');
  }
}

Future<void> writeCsvFile(File outputFile, Set<Word> wordSet) async {
  bool exitCondition = false;
  FileMode result = FileMode.append;
  do {
    print('파일을 처음부터 만들까요?');
    String? li = stdin.readLineSync();
    print('입력값: $li');

    if (li == null) {
      continue;
    }

    if (li.startsWith('y')) {
      exitCondition = true;
      result = FileMode.write;
      break;
    } else if (li.startsWith('n')) {
      exitCondition = true;
      result = FileMode.append;
      break;
    }
  } while (!exitCondition);

  IOSink sink = outputFile.openWrite(mode: result);

  sink.writeAll(wordSet, Platform.lineTerminator);
  await sink.flush();
  await sink.close();
}

Future<void> checkFiles(
  Directory inputDirectory,
  Directory outputDirectory,
  File outputFile,
) async {
  {
    if (!await inputDirectory.exists()) {
      print('오류: "words" input 폴더를 찾을 수 없습니다. 폴더와 파일을 생성해 주세요.');
      throw Exception();
    }
    if (!await outputDirectory.exists()) {
      print('오류: "words" output 폴더를 찾을 수 없습니다. 폴더와 파일을 생성해 주세요.');
      throw Exception();
    }

    if (!await outputFile.exists()) {
      print('create output file.');
      await outputFile.create();
    }
  }
}

Future<Set<Word>> rawFileRead(File file, String categoryName) async {
  print('파일 처리 : ${file.path}');

  final lines = await file.readAsLines();
  int difficulty = 0;
  final wordSet = <Word>{};

  for (final line in lines) {
    // increase difficulty
    difficulty++;

    // Iterable<Word> words = readRawFileLine(line, difficulty, categoryName);

    // print('난이도 : $difficulty, 단어 수: ${words.length}');
    // wordSet.addAll(words);
  }
  return wordSet;
}

/// read one line in raw text file
// // Iterable<Word> readRawFileLine(
// //   String line,
// //   int difficulty,
// //   String categoryName,
// // ) {
//   // print(wordStrings);
//   return line
//       .split(',')
//       // Remove all characters except Korean, English letters, and numbers for word normalization.
//       .map((string) => string.trim().replaceAll(RegExp(r'[^a-zA-Z0-9가-힣]'), ''))
//       .where((string) => string.isNotEmpty)
//       .map((string) => Word(

//         string, difficulty, categoryName, id: null, title: '', diff: difficulty));
// }
