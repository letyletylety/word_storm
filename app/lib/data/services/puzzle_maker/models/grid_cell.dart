// lib/models/grid_cell.dart (예시)

// CellStatus: 초기, 발견됨, 사용됨 등 상태 정의
import 'package:built_value/built_value.dart';

part 'grid_cell.g.dart';

enum CellStatus { initial, found, usedInWord }

abstract class GridCell implements Built<GridCell, GridCellBuilder> {
  // 글자 자체 (GridLetters의 각 요소)
  String get letter;

  // 초기 상태: 게임 시작 시에는 항상 initial
  CellStatus get status;

  // 격자 내의 고유 ID (0부터 63까지)
  int get index;

  GridCell._();

  factory GridCell([void Function(GridCellBuilder)? updates]) = _$GridCell;
}
