import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperCellView extends StatelessWidget {
  /// The data for the row
  final dynamic rowData;

  /// The value for this cell
  final String cellValue;

  /// The identifier of the column
  final String identifier;

  final int index;

  final double? height;

  ZooperCellView({
    required this.rowData,
    required this.cellValue,
    required this.identifier,
    required this.index,
    required this.height,
  }) : super(key: ValueKey('cell:$identifier:$index'));

  @override
  Widget build(BuildContext context) {
    return Consumer2<TableConfigurationNotifier, ColumnStateNotifier>(
      builder: (context, tableConfigurationNotifier, columnStateProvider, child) {
        final columnIndex = columnStateProvider.currentState.indexWhere((element) => element.identifier == identifier);
        final column = columnStateProvider.currentState.firstWhere((element) => element.identifier == identifier);

        return Container(
          width: column.width,
          height: height,
          padding: tableConfigurationNotifier.currentState.cellConfiguration
              .paddingBuilder(rowData, identifier, columnIndex),
          decoration: BoxDecoration(
            border: tableConfigurationNotifier.currentState.cellConfiguration
                .borderBuilder(rowData, identifier, columnIndex),
          ),
          child: Text(
            cellValue,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
