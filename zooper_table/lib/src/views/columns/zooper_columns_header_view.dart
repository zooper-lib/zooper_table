import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperColumnsHeaderView extends StatelessWidget {
  const ZooperColumnsHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<TableConfigurationNotifier, TableState, ColumnStateNotifier>(
        builder: (context, tableConfigState, tableState, columnState, child) {
      final columnViewList = buildColumnViewList(tableConfigState.currentState, columnState.currentState);

      return Container(
        height: tableConfigState.currentState.columnConfiguration.heightBuilder.call(),
        decoration: BoxDecoration(
          border: tableConfigState.currentState.columnConfiguration.headerBorderBuilder(),
        ),
        child: Row(
          children: columnViewList,
        ),
      );
    });
  }

  List<Widget> buildColumnViewList(TableConfiguration tableConfiguration, List<ColumnData> columns) {
    var columnHeaderItems = <Widget>[];

    // Add the drag handle
    final dragHandle = _buildDragHandleSpacing(tableConfiguration);
    columnHeaderItems.add(dragHandle);

    for (final column in columns) {
      final columnHeaderItemView = buildColumnItem(
        column,
      );
      columnHeaderItems.add(columnHeaderItemView);
    }

    return columnHeaderItems;
  }

  ZooperColumnView buildColumnItem(ColumnData columnModel) {
    return ZooperColumnView(identifier: columnModel.identifier);
  }

  Widget _buildDragHandleSpacing(TableConfiguration tableConfiguration) {
    return SizedBox(
      width: tableConfiguration.rowConfiguration.rowDragConfiguration.widthBuilder(0, null),
    );
  }
}
