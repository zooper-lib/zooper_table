import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Consumer(
      builder: (context, ref, child) {
        final column = ref.watch(columnStateProvider).firstWhere((element) => element.identifier == identifier);
        final columnIndex = ref.watch(columnStateProvider).indexWhere((element) => element.identifier == identifier);
        final tableConfigurationNotifier = ref.watch(tableConfigurationProvider);

        return Container(
          width: column.width,
          height: height,
          padding: tableConfigurationNotifier.cellConfiguration.paddingBuilder(rowData, identifier, columnIndex),
          decoration: BoxDecoration(
            border: tableConfigurationNotifier.cellConfiguration.borderBuilder(rowData, identifier, columnIndex),
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
