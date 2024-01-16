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
              final dragHandle = _buildDragHandleSpacing(tableConfigState.currentState);

              return Container(
                height: tableConfigState.currentState.columnConfiguration.heightBuilder(),
                decoration: BoxDecoration(
                  border: tableConfigState.currentState.columnConfiguration.headerBorderBuilder(),
                ),
                child: Row(
                  children: [
                    dragHandle,
                    _buildDraggableColumnView(context, columnService, tableConfigState.currentState,
                        columnState.dataColumns, ColumnStick.left),
                    _buildDraggableColumnView(context, columnService, tableConfigState.currentState,
                        columnState.dataColumns, ColumnStick.center),
                    _buildDraggableColumnView(context, columnService, tableConfigState.currentState,
                        columnState.dataColumns, ColumnStick.right),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildDraggableColumnView(
    BuildContext context,
    ColumnService columnService,
    TableConfiguration tableConfig,
    List<ColumnData> columnDataList,
    ColumnStick columnStick,
  ) {
    final columnsWidth = columnService.getColumnWidthByStick(columnStick);
    final columnViewList = _buildColumnViewList(tableConfig, columnDataList, columnStick);

    return SizedBox(
      width: columnsWidth,
      child: ReorderableListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        buildDefaultDragHandles: false,
        onReorder: (oldIndex, newIndex) => columnService.reorderColumn(columnStick, oldIndex, newIndex),
        children: columnViewList,
      ),
    );
  }

  List<Widget> _buildColumnViewList(
    TableConfiguration tableConfiguration,
    List<ColumnData> columns,
    ColumnStick columnStick,
  ) {
    final filteredColumns = columns.where((element) => element.columnStick == columnStick).toList();

    var columnHeaderItems = <Widget>[];

    for (final column in filteredColumns) {
      final columnHeaderItemView = _buildColumnItem(column);
      columnHeaderItems.add(columnHeaderItemView);
    }

    return columnHeaderItems;
  }

  ZooperColumnView _buildColumnItem(ColumnData columnModel) {
    return ZooperColumnView(identifier: columnModel.identifier);
  }

  Widget _buildDragHandleSpacing(TableConfiguration tableConfiguration) {
    return SizedBox(
      key: const ValueKey('dragHandleSpacing'),
      width: tableConfiguration.rowConfiguration.rowDragConfiguration.widthBuilder(0, null),
    );
  }
}
