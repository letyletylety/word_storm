// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grid_cell.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GridCell extends GridCell {
  @override
  final String letter;
  @override
  final CellStatus status;
  @override
  final int index;

  factory _$GridCell([void Function(GridCellBuilder)? updates]) =>
      (GridCellBuilder()..update(updates))._build();

  _$GridCell._({
    required this.letter,
    required this.status,
    required this.index,
  }) : super._();
  @override
  GridCell rebuild(void Function(GridCellBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GridCellBuilder toBuilder() => GridCellBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GridCell &&
        letter == other.letter &&
        status == other.status &&
        index == other.index;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, letter.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, index.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GridCell')
          ..add('letter', letter)
          ..add('status', status)
          ..add('index', index))
        .toString();
  }
}

class GridCellBuilder implements Builder<GridCell, GridCellBuilder> {
  _$GridCell? _$v;

  String? _letter;
  String? get letter => _$this._letter;
  set letter(String? letter) => _$this._letter = letter;

  CellStatus? _status;
  CellStatus? get status => _$this._status;
  set status(CellStatus? status) => _$this._status = status;

  int? _index;
  int? get index => _$this._index;
  set index(int? index) => _$this._index = index;

  GridCellBuilder();

  GridCellBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _letter = $v.letter;
      _status = $v.status;
      _index = $v.index;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GridCell other) {
    _$v = other as _$GridCell;
  }

  @override
  void update(void Function(GridCellBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GridCell build() => _build();

  _$GridCell _build() {
    final _$result =
        _$v ??
        _$GridCell._(
          letter: BuiltValueNullFieldError.checkNotNull(
            letter,
            r'GridCell',
            'letter',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'GridCell',
            'status',
          ),
          index: BuiltValueNullFieldError.checkNotNull(
            index,
            r'GridCell',
            'index',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
