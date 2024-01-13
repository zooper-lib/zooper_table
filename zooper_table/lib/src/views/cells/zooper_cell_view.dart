import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperCellView extends StatelessWidget {
  /// The identifier of the column
  final String identifier;

  final int columnIndex;
  final int rowIndex;

  final dynamic cellValue;

  /// The width of the column
  /// Note: We pass it because there is no need for the cell to calculate it by its own
  final double columnWidth;

  /// The height of the row
  /// Note: We pass it because there is no need for the cell to calculate it by its own
  final double? rowHeight;

  ZooperCellView({
    required this.columnIndex,
    required this.identifier,
    required this.rowIndex,
    required this.cellValue,
    required this.columnWidth,
    required this.rowHeight,
  }) : super(key: ValueKey('cell:$identifier:$rowIndex'));

  @override
  Widget build(BuildContext context) {
    return Consumer4<TableConfigurationNotifier, TableState, ColumnService, CellService>(
      builder: (context, tableConfigurationNotifier, tableState, columnService, cellService, child) {
        return Container(
          width: columnWidth,
          height: rowHeight,
          padding: tableConfigurationNotifier.currentState.cellConfiguration
              .paddingBuilder(identifier, columnIndex, rowIndex, cellValue),
          decoration: BoxDecoration(
            border: tableConfigurationNotifier.currentState.cellConfiguration
                .borderBuilder(cellValue, identifier, columnIndex, rowIndex),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              cellValue.toString(),
              overflow: TextOverflow.ellipsis,
            ),
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
