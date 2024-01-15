import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperColumnView extends StatelessWidget {
  final String identifier;

  ZooperColumnView({
    required this.identifier,
  }) : super(key: ValueKey('column:$identifier'));

  @override
  Widget build(BuildContext context) {
    return Consumer4<TableConfigurationNotifier, TableState, ColumnState, ColumnService>(
      builder: (context, tableConfigurationNotifier, tableState, columnStateNotifier, columnService, child) {
        final columnIndex = columnService.getAbsoluteColumnIndexByIdentifier(identifier);

        final columnWidth = columnService.getColumnWidth(identifier);
        final minWidth = tableConfigurationNotifier.currentState.columnConfiguration.minWidthBuilder(identifier);
        final maxWidth = tableConfigurationNotifier.currentState.columnConfiguration.maxWidthBuilder(identifier);

        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minWidth,
            maxWidth: maxWidth,
          ),
          child: SizedBox(
            width: columnWidth,
            child: Stack(
              children: [
                // Content
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: columnWidth,
                    padding: tableConfigurationNotifier.currentState.columnConfiguration.paddingBuilder(identifier),
                    decoration: BoxDecoration(
                      border: tableConfigurationNotifier.currentState.columnConfiguration
                          .borderBuilder(identifier, columnIndex),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _title(context),
                        _sortIcon(context),
                      ],
                    ),
                  ),
                ),

                // Resize handle
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: ResizeHandleView(
                    columnIdentifier: identifier,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _title(BuildContext context) {
    return Consumer3<TableConfigurationNotifier, ColumnState, ColumnService>(
      builder: (context, tableConfigurationNotifier, columnStateNotifier, columnService, child) {
        var column = columnStateNotifier.dataColumns.firstWhere((element) => element.identifier == identifier);

        // The column index must be calculated by the
        var relativeColumnIndex = columnService.getRelativeColumnIndexByIdentifier(column.identifier);

        return Expanded(
          child: ReorderableDragStartListener(
            index: relativeColumnIndex,
            child: GestureDetector(
              onTap: () => columnService.sortColumn(column.identifier),
              child: Text(
                column.title,
                overflow: TextOverflow.ellipsis,
                style: tableConfigurationNotifier.currentState.columnConfiguration.textStyleBuilder(identifier),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sortIcon(BuildContext context) {
    return Consumer4<TableConfigurationNotifier, TableState, ColumnState, ColumnService>(
      builder: (context, tableConfigurationNotifier, tableState, columnStateNotifier, columnService, child) {
        final column = columnStateNotifier.dataColumns.firstWhere((element) => element.identifier == identifier);

        final columnSortOrder = tableState.currentState.primaryColumnSort == null
            ? null
            : tableState.currentState.primaryColumnSort?.identifier != identifier
                ? null
                : tableState.currentState.primaryColumnSort?.sortOrder;

        if (tableConfigurationNotifier.currentState.columnConfiguration.canSortBuilder(identifier) == false) {
          return const SizedBox.shrink();
        }

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => columnService.sortColumn(column.identifier),
            child: columnSortOrder == null
                ? const SizedBox.shrink()
                : columnSortOrder == SortOrder.descending
                    ? tableConfigurationNotifier.currentState.columnConfiguration.sortDescendingIconBuilder(identifier)
                    : tableConfigurationNotifier.currentState.columnConfiguration.sortAscendingIconBuilder(identifier),
          ),
        );
      },
    );
  }
}
