// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'puzzle_board.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PuzzleBoard> _$puzzleBoardSerializer = _$PuzzleBoardSerializer();

class _$PuzzleBoardSerializer implements StructuredSerializer<PuzzleBoard> {
  @override
  final Iterable<Type> types = const [PuzzleBoard, _$PuzzleBoard];
  @override
  final String wireName = 'PuzzleBoard';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    PuzzleBoard object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'gridCells',
      serializers.serialize(
        object.gridCells,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GridCell),
        ]),
      ),
      'gridLetters',
      serializers.serialize(
        object.gridLetters,
        specifiedType: const FullType(BuiltList, const [
          const FullType(String),
        ]),
      ),
      'validWords',
      serializers.serialize(
        object.validWords,
        specifiedType: const FullType(BuiltSet, const [const FullType(String)]),
      ),
      'foundWords',
      serializers.serialize(
        object.foundWords,
        specifiedType: const FullType(BuiltSet, const [const FullType(String)]),
      ),
    ];

    return result;
  }

  @override
  PuzzleBoard deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PuzzleBoardBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'gridCells':
          result.gridCells.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GridCell),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'gridLetters':
          result.gridLetters.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(String),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'validWords':
          result.validWords.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltSet, const [
                    const FullType(String),
                  ]),
                )!
                as BuiltSet<Object?>,
          );
          break;
        case 'foundWords':
          result.foundWords.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltSet, const [
                    const FullType(String),
                  ]),
                )!
                as BuiltSet<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$PuzzleBoard extends PuzzleBoard {
  @override
  final BuiltList<GridCell> gridCells;
  @override
  final BuiltList<String> gridLetters;
  @override
  final BuiltSet<String> validWords;
  @override
  final BuiltSet<String> foundWords;

  factory _$PuzzleBoard([void Function(PuzzleBoardBuilder)? updates]) =>
      (PuzzleBoardBuilder()..update(updates))._build();

  _$PuzzleBoard._({
    required this.gridCells,
    required this.gridLetters,
    required this.validWords,
    required this.foundWords,
  }) : super._();
  @override
  PuzzleBoard rebuild(void Function(PuzzleBoardBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PuzzleBoardBuilder toBuilder() => PuzzleBoardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PuzzleBoard &&
        gridCells == other.gridCells &&
        gridLetters == other.gridLetters &&
        validWords == other.validWords &&
        foundWords == other.foundWords;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, gridCells.hashCode);
    _$hash = $jc(_$hash, gridLetters.hashCode);
    _$hash = $jc(_$hash, validWords.hashCode);
    _$hash = $jc(_$hash, foundWords.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PuzzleBoard')
          ..add('gridCells', gridCells)
          ..add('gridLetters', gridLetters)
          ..add('validWords', validWords)
          ..add('foundWords', foundWords))
        .toString();
  }
}

class PuzzleBoardBuilder implements Builder<PuzzleBoard, PuzzleBoardBuilder> {
  _$PuzzleBoard? _$v;

  ListBuilder<GridCell>? _gridCells;
  ListBuilder<GridCell> get gridCells =>
      _$this._gridCells ??= ListBuilder<GridCell>();
  set gridCells(ListBuilder<GridCell>? gridCells) =>
      _$this._gridCells = gridCells;

  ListBuilder<String>? _gridLetters;
  ListBuilder<String> get gridLetters =>
      _$this._gridLetters ??= ListBuilder<String>();
  set gridLetters(ListBuilder<String>? gridLetters) =>
      _$this._gridLetters = gridLetters;

  SetBuilder<String>? _validWords;
  SetBuilder<String> get validWords =>
      _$this._validWords ??= SetBuilder<String>();
  set validWords(SetBuilder<String>? validWords) =>
      _$this._validWords = validWords;

  SetBuilder<String>? _foundWords;
  SetBuilder<String> get foundWords =>
      _$this._foundWords ??= SetBuilder<String>();
  set foundWords(SetBuilder<String>? foundWords) =>
      _$this._foundWords = foundWords;

  PuzzleBoardBuilder();

  PuzzleBoardBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _gridCells = $v.gridCells.toBuilder();
      _gridLetters = $v.gridLetters.toBuilder();
      _validWords = $v.validWords.toBuilder();
      _foundWords = $v.foundWords.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PuzzleBoard other) {
    _$v = other as _$PuzzleBoard;
  }

  @override
  void update(void Function(PuzzleBoardBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PuzzleBoard build() => _build();

  _$PuzzleBoard _build() {
    _$PuzzleBoard _$result;
    try {
      _$result =
          _$v ??
          _$PuzzleBoard._(
            gridCells: gridCells.build(),
            gridLetters: gridLetters.build(),
            validWords: validWords.build(),
            foundWords: foundWords.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'gridCells';
        gridCells.build();
        _$failedField = 'gridLetters';
        gridLetters.build();
        _$failedField = 'validWords';
        validWords.build();
        _$failedField = 'foundWords';
        foundWords.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PuzzleBoard',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
