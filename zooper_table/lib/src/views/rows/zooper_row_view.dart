import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperRowView<T> extends StatelessWidget {
  /// The data for this row
  final ZooperRowModel row;

  /// The index of this row inside the Table
  final int rowIndex;

  const ZooperRowView({
    super.key,
    required this.row,
    required this.rowIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<TableConfigurationNotifier, ColumnStateNotifier>(
        builder: (context, tableConfigurationNotifier, columnState, child) {
      // Get the available columns
      var columns = columnState.currentState;

      // Construct the cells for this row
      var cellViews = _buildCells(tableConfigurationNotifier.currentState, columns);

      return Row(
        children: cellViews,
      );
    });
  }

  List<Widget> _buildCells(TableConfiguration tableConfiguration, List<ZooperColumnModel> columns) {
    var cells = <Widget>[];

    for (var index = 0; index < columns.length; index++) {
      final cellView = _buildCell(tableConfiguration, columns[index], index);
      cells.add(cellView);
    }

    return cells;
  }

  // TODO: The parameters probably need to change when ordering columns will be implemented
  Widget _buildCell(TableConfiguration tableConfiguration, ZooperColumnModel columnModel, int columnIndex) {
    return Consumer3<TableState, ColumnService, RowService>(
      builder: (context, tableState, columnService, rowService, child) {
        final width = columnService.getColumnWidth(columnModel.identifier);
        final height = rowService.getRowHeight(row.identifier, rowIndex);
        final cellValue = tableConfiguration.valueGetter(row.data, columnModel.identifier);

        return ZooperCellView(
          tableConfiguration: tableConfiguration,
          columnIndex: columnIndex,
          cellValue: cellValue,
          identifier: columnModel.identifier,
          rowIndex: rowIndex,
          columnWidth: width,
          rowHeight: height,
        );
      },
    );
  }
}
