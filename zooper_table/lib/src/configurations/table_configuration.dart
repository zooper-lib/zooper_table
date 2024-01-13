import 'package:zooper_table/zooper_table.dart';

class TableConfiguration {
  /// Configuration for the column headers of this table.
  final ColumnConfiguration columnConfiguration;

  /// Configuration for the rows of this table.
  final RowConfiguration rowConfiguration;

  /// Configuration for the cells of this table.
  final CellConfiguration cellConfiguration;

  /// The function that will be used to get the value of a cell.
  final dynamic Function(dynamic data, String identifier) valueGetter;

  /// The initial order of the columns.
  final List<String> initialColumnOrder;

  /// Configuration for callbacks of this table.
  final CallbackConfiguration callbackConfiguration;

  TableConfiguration({
    ColumnConfiguration? columnConfiguration,
    RowConfiguration? rowConfiguration,
    CellConfiguration? cellConfiguration,
    required this.valueGetter,
    this.initialColumnOrder = const [],
    CallbackConfiguration? callbackConfiguration,
  })  : columnConfiguration = columnConfiguration ?? ColumnConfiguration(),
        rowConfiguration = rowConfiguration ?? RowConfiguration(),
        cellConfiguration = cellConfiguration ?? CellConfiguration(),
        callbackConfiguration = callbackConfiguration ?? CallbackConfiguration();
}
