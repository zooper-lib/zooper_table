import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperRowView<T> extends StatelessWidget {
  /// The data for this row
  /// Note: This is already the sorted list, so we get it here instead of inside the cell
  final RowData row;

  /// The index of this row inside the Table
  final int rowIndex;

  ZooperRowView({
    required this.row,
    required this.rowIndex,
  }) : super(key: ValueKey('row:$rowIndex'));

  @override
  Widget build(BuildContext context) {
    return Consumer3<RowService, TableConfigurationNotifier, ColumnStateNotifier>(
      builder: (context, rowService, tableConfigurationNotifier, columnState, child) {
        // Get the available columns
        var columns = columnState.currentState;

        // Construct the cells for this row
        var cellViews = _buildCells(tableConfigurationNotifier.currentState, columns);

        // Get the separator for this row
        var separator = tableConfigurationNotifier.currentState.rowConfiguration.separatorBuilder(rowIndex);

        return Column(
          children: [
            InkWell(
              onTap: () => rowService.onRowTap(row),
              child: Container(
                height: rowService.getRowHeight(row.identifier, rowIndex),
                decoration: BoxDecoration(
                  border: tableConfigurationNotifier.currentState.rowConfiguration.borderBuilder(
                    row.identifier,
                    rowIndex,
                    row.isSelected,
                  ),
                  color: row.isSelected
                      ? tableConfigurationNotifier.currentState.rowConfiguration
                          .selectedBackgroundColorBuilder(row.identifier, rowIndex)
                      : Colors.transparent,
                ),
                child: Row(
                  children: cellViews,
                ),
              ),
            ),
            separator,
          ],
        );
      },
    );
  }

  List<Widget> _buildCells(TableConfiguration tableConfiguration, List<ColumnData> columns) {
    var cells = <Widget>[];

    // Add the drag handle if needed
    final dragHandle = RowDragHandleView(rowIndex: rowIndex);

    cells.add(dragHandle);

    for (var index = 0; index < columns.length; index++) {
      final cellView = _buildCell(tableConfiguration, columns[index], index);
      cells.add(cellView);
    }

    return cells;
  }

  // TODO: The parameters probably need to change when ordering columns will be implemented
  Widget _buildCell(TableConfiguration tableConfiguration, ColumnData columnModel, int columnIndex) {
    return Consumer3<TableState, ColumnService, RowService>(
      builder: (context, tableState, columnService, rowService, child) {
        final width = columnService.getColumnWidth(columnModel.identifier);
        final height = rowService.getRowHeight(row.identifier, rowIndex);
        final cellValue = tableConfiguration.valueGetter(row.data, columnModel.identifier);

        return ZooperCellView(
          columnIndex: columnIndex,
          identifier: columnModel.identifier,
          rowIndex: rowIndex,
          cellValue: cellValue,
          columnWidth: width,
          rowHeight: height,
        );
      },
    );
  }
}
