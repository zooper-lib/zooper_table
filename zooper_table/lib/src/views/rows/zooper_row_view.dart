import 'package:flutter/widgets.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperRowView<T> extends StatelessWidget {
  /// Configuration for this row
  final RowConfiguration rowConfiguration;

  final CellConfiguration<T> cellConfiguration;

  /// The columns of the table
  final List<ZooperColumnModel> columns;

  /// The data for this row
  final T data;

  /// The index of this row inside the Table
  final int index;

  const ZooperRowView({
    super.key,
    required this.rowConfiguration,
    required this.cellConfiguration,
    required this.columns,
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cells = _buildCells();

    return Row(
      children: cells,
    );
  }

  List<ZooperCellView> _buildCells() {
    var cells = <ZooperCellView<T>>[];

    for (final column in columns) {
      final cellView = _buildCell(column);
      cells.add(cellView);
    }

    return cells;
  }

  ZooperCellView<T> _buildCell(ZooperColumnModel columnModel) {
    final height = rowConfiguration.heightBuilder(index);

    return ZooperCellView<T>(
      rowData: data,
      cellValue: cellConfiguration.cellValue(data, columnModel.identifier),
      identifier: columnModel.identifier,
      height: height,
    );
  }
}
