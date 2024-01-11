import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperRowView<T> extends StatelessWidget {
  /// The columns of the table
  final List<ZooperColumnModel> columns;

  /// The data for this row
  final T data;

  /// The index of this row inside the Table
  final int index;

  ZooperRowView({
    required this.columns,
    required this.data,
    required this.index,
  }) : super(key: ValueKey('row:$index'));

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
      final cellView = _buildCell(columns[index]);
      cells.add(cellView);
    }

    return cells;
  }

  Widget _buildCell(ZooperColumnModel columnModel) {
    return Consumer<TableConfigurationNotifier>(builder: (context, tableConfigurationNotifier, child) {
      final height = tableConfigurationNotifier.currentState.rowConfiguration.heightBuilder(index);
      final cellValue = tableConfigurationNotifier.currentState.valueGetter(data, columnModel.identifier);

      return ZooperCellView(
        rowData: data,
        cellValue: cellValue,
        identifier: columnModel.identifier,
        index: index,
        height: height,
      );
    });
  }
}
