import 'package:flutter/widgets.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperRowView<T> extends StatelessWidget {
  final TableConfiguration tableConfiguration;

  /// The columns of the table
  final List<ZooperColumnModel> columns;

  /// The data for this row
  final ZooperRowModel row;

  /// The index of this row inside the Table
  final int rowIndex;

  ZooperRowView({
    required this.tableConfiguration,
    required this.columns,
    required this.row,
    required this.rowIndex,
  }) : super(key: ValueKey('row:$rowIndex'));

  @override
  Widget build(BuildContext context) {
    final cells = _buildCells();

    return Row(
      children: cells,
    );
  }

  List<Widget> _buildCells() {
    var cells = <Widget>[];

    for (var index = 0; index < columns.length; index++) {
      final cellView = _buildCell(columns[index], index);
      cells.add(cellView);
    }

    return cells;
  }

  Widget _buildCell(ZooperColumnModel columnModel, int columnIndex) {
    final height = tableConfiguration.rowConfiguration.heightBuilder(row.identifier, rowIndex);
    final cellValue = tableConfiguration.valueGetter(row.data, columnModel.identifier);

    return ZooperCellView(
      tableConfiguration: tableConfiguration,
      column: columnModel,
      columnIndex: columnIndex,
      cellValue: cellValue,
      identifier: columnModel.identifier,
      rowIndex: rowIndex,
      height: height,
    );
  }
}
