import 'package:zooper_table/zooper_table.dart';

class TableConfiguration<T> {
  /// Configuration for the column headers of this table.
  final ColumnConfiguration columnHeaderConfiguration;

  /// Configuration for the rows of this table.
  final RowConfiguration<T> rowConfiguration;

  /// Configuration for the cells of this table.
  final CellConfiguration<T> cellConfiguration;

  TableConfiguration({
    required this.columnHeaderConfiguration,
    required this.rowConfiguration,
    required this.cellConfiguration,
  });
}
