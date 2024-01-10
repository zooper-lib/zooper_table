import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperCellView<TData> extends StatelessWidget {
  /// The data for the row
  final TData rowData;

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
    return Consumer2<ColumnStateNotifier<TData>, TableConfigurationNotifier<TData>>(
      builder: (context, columnStateNotifier, tableConfigurationNotifier, child) {
        final column = columnStateNotifier.getColumn(identifier);

        return Container(
          width: column.width,
          height: height,
          padding:
              tableConfigurationNotifier.tableConfiguration.cellConfiguration.paddingBuilder(rowData, identifier, 0),
          child: Text(
            cellValue,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
