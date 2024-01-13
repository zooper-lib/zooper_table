import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperColumnsHeaderView extends StatelessWidget {
  const ZooperColumnsHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) => Consumer4<TableConfigurationNotifier, TableState, ColumnState, ColumnService>(
            builder: (context, tableConfigState, tableState, columnState, columnService, child) {
              final columnViewList = buildColumnViewList(tableConfigState.currentState, columnState.currentState);

              final dragHandle = _buildDragHandleSpacing(tableConfigState.currentState);

              return Container(
                height: tableConfigState.currentState.columnConfiguration.heightBuilder(),
                decoration: BoxDecoration(
                  border: tableConfigState.currentState.columnConfiguration.headerBorderBuilder(),
                ),
                child: Row(
                  children: [
                    dragHandle,
                    Expanded(
                      child: ReorderableListView(
                        scrollDirection: Axis.horizontal,
                        buildDefaultDragHandles: false,
                        onReorder: (oldIndex, newIndex) => columnService.reorderColumn(oldIndex, newIndex),
                        children: columnViewList,
                      ),
                    ),
                  ],
                ),

                /* child: ReorderableRow(
                  onReorder: (oldIndex, newIndex) => columnService.reorderColumn(oldIndex, newIndex),
                  children: columnViewList,
                ), */
              );
            },
          ),
        )
      ],
    );
  }

  List<Widget> buildColumnViewList(TableConfiguration tableConfiguration, List<ColumnData> columns) {
    var columnHeaderItems = <Widget>[];

    // Add the drag handle
    //final dragHandle = _buildDragHandleSpacing(tableConfiguration);
    //columnHeaderItems.add(dragHandle);

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
      key: const ValueKey('dragHandleSpacing'),
      width: tableConfiguration.rowConfiguration.rowDragConfiguration.widthBuilder(0, null),
    );
  }
}
