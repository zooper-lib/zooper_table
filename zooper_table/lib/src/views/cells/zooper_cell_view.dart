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

  final double? height;

  const ZooperCellView({
    Key? key,
    required this.rowData,
    required this.cellValue,
    required this.identifier,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var column = ref.watch(columnStateProvider).firstWhere((element) => element.identifier == identifier);
        var tableConfigurationNotifier = ref.watch(tableConfigurationProvider);

        return Container(
          width: column.width,
          height: height,
          padding: tableConfigurationNotifier.cellConfiguration.paddingBuilder(rowData, identifier, 0),
          child: Text(
            cellValue,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
