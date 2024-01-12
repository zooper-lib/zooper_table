import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperCellView extends StatelessWidget {
  final TableConfiguration tableConfiguration;

  /// The identifier of the column
  final String identifier;

  final int columnIndex;
  final int rowIndex;

  /// The value for this cell
  // TODO: Get the cell value based on column index and row index
  final dynamic cellValue;

  /// The width of the column
  /// Note: We pass it because there is no need for the cell to calculate it by its own
  final double columnWidth;

  /// The height of the row
  /// Note: We pass it because there is no need for the cell to calculate it by its own
  final double? rowHeight;

  ZooperCellView({
    required this.tableConfiguration,
    required this.columnIndex,
    required this.cellValue,
    required this.identifier,
    required this.rowIndex,
    required this.columnWidth,
    required this.rowHeight,
  }) : super(key: ValueKey('cell:$identifier:$rowIndex'));

  @override
  Widget build(BuildContext context) {
    return Consumer3<TableConfigurationNotifier, TableState, ColumnService>(
      builder: (context, tableConfigState, tableState, columnService, child) {
        return Container(
          width: columnWidth,
          height: rowHeight,
          padding: tableConfiguration.cellConfiguration.paddingBuilder(identifier, columnIndex, rowIndex, cellValue),
          decoration: BoxDecoration(
            border: tableConfiguration.cellConfiguration.borderBuilder(cellValue, identifier, rowIndex),
          ),
          child: Text(
            cellValue.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return key.toString();
  }
}
