import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperColumnsHeaderView extends StatelessWidget {
  const ZooperColumnsHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<TableState, ColumnStateNotifier>(builder: (context, tableState, columnState, child) {
      final columnViewList = buildColumnViewList(columnState.currentState);

      return Row(
        children: columnViewList,
      );
    });
  }

  List<ZooperColumnView> buildColumnViewList(List<ZooperColumnModel> columns) {
    var columnHeaderItems = <ZooperColumnView>[];

    for (final column in columns) {
      final columnHeaderItemView = buildColumnItem(
        column,
      );
      columnHeaderItems.add(columnHeaderItemView);
    }

    return columnHeaderItems;
  }

  ZooperColumnView buildColumnItem(ZooperColumnModel columnModel) {
    return ZooperColumnView(identifier: columnModel.identifier);
  }
}
