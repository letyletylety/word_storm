library models;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'models.g.dart';

abstract class PuzzleBoard implements Built<PuzzleBoard, PuzzleBoardBuilder> {
  // Built_value 보일러 플레이트
  static Serializer<PuzzleBoard> get serializer => _$puzzleBoardSerializer;

  // 1. 격자 글자 목록
  BuiltList<String> get gridLetters;

  // 2. 현재 정답 목록 (전체)
  BuiltSet<String> get validWords;

  // 3. 찾은 단어 목록
  BuiltSet<String> get foundWords;

  // 기본 생성자
  PuzzleBoard._();

  // 팩토리 생성자
  factory PuzzleBoard([void Function(PuzzleBoardBuilder) updates]) =
      _$PuzzleBoard;
}
