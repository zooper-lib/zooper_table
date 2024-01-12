import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperCellView extends StatelessWidget {
  final TableConfiguration tableConfiguration;

  final ZooperColumnModel column;

  /// The identifier of the column
  final String identifier;

  final int columnIndex;
  final int rowIndex;

  /// The value for this cell
  final dynamic cellValue;

  final double? height;

  ZooperCellView({
    required this.tableConfiguration,
    required this.column,
    required this.columnIndex,
    required this.cellValue,
    required this.identifier,
    required this.rowIndex,
    required this.height,
  }) : super(key: ValueKey('cell:$identifier:$rowIndex'));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: column.width,
      height: height,
      padding: tableConfiguration.cellConfiguration.paddingBuilder(identifier, columnIndex, rowIndex, cellValue),
      decoration: BoxDecoration(
        border: tableConfiguration.cellConfiguration.borderBuilder(cellValue, identifier, rowIndex),
      ),
      child: Text(
        cellValue.toString(),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
