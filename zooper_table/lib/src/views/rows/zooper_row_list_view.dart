import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperRowListView extends StatelessWidget {
  const ZooperRowListView({super.key});

  @override
  Widget build(BuildContext context) {
    // We use the Overlay outside of the Consumer because else it would not be updating its content
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) => Consumer3<RowService, TableState, RowState>(
            builder: (context, rowService, tableState, rowState, child) {
              var rowViews = buildRowViewList(rowState.currentState);

              return CustomScrollView(
                controller: ScrollController(),
                slivers: <Widget>[
                  ReorderableSliverList(
                    enabled: rowService.isReorderingEnabled(),
                    delegate: ReorderableSliverChildListDelegate(
                      rowViews,
                    ),
                    onReorder: (oldIndex, newIndex) => {
                      //tableService.reorderRow(oldIndex, newIndex),
                      print('Reorder from $oldIndex to $newIndex'),
                    },
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  List<ZooperRowView> buildRowViewList(List<ZooperRowModel> rows) {
    var rowViewList = <ZooperRowView>[];

    // This should be be sorted rows
    for (int i = 0; i < rows.length; i++) {
      final row = _buildRowView(rows[i], i);
      rowViewList.add(row);
    }

    return rowViewList;
  }

  ZooperRowView _buildRowView(ZooperRowModel rowModel, int index) {
    return ZooperRowView(
      row: rowModel,
      rowIndex: index,
    );
  }
}
