import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ZooperColumnView extends StatelessWidget {
  final String identifier;

  ZooperColumnView({
    required this.identifier,
  }) : super(key: ValueKey('column:$identifier'));

  @override
  Widget build(BuildContext context) {
    return Consumer2<TableConfigurationNotifier, ColumnStateNotifier>(
      builder: (context, tableConfigurationNotifier, columnStateNotifier, child) {
        final columnIndex = columnStateNotifier.currentState.indexWhere((element) => element.identifier == identifier);
        final minWidth = tableConfigurationNotifier.currentState.columnConfiguration.minWidthBuilder(identifier);
        final maxWidth = tableConfigurationNotifier.currentState.columnConfiguration.maxWidthBuilder(identifier);

        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minWidth,
            maxWidth: maxWidth,
          ),
          child: Container(
            width: columnStateNotifier.currentState.firstWhere((element) => element.identifier == identifier).width,
            padding: tableConfigurationNotifier.currentState.columnConfiguration.paddingBuilder(identifier),
            decoration: BoxDecoration(
              border:
                  tableConfigurationNotifier.currentState.columnConfiguration.borderBuilder(identifier, columnIndex),
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _title(context),
                _sortIcon(context),
                _resizeIcon(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _title(BuildContext context) {
    return Consumer2<ColumnStateNotifier, ColumnService>(
      builder: (context, columnStateNotifier, columnService, child) {
        var column = columnStateNotifier.currentState.firstWhere((element) => element.identifier == identifier);

        return Expanded(
          child: GestureDetector(
            onTap: () => columnService.sortColumn(column.identifier),
            child: Text(
              column.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }

  Widget _sortIcon(BuildContext context) {
    return Consumer3<TableConfigurationNotifier, ColumnStateNotifier, ColumnService>(
      builder: (context, tableConfigurationNotifier, columnStateNotifier, columnService, child) {
        final column = columnStateNotifier.currentState.firstWhere((element) => element.identifier == identifier);

        if (tableConfigurationNotifier.currentState.columnConfiguration.canSortBuilder(identifier) == false) {
          return const SizedBox.shrink();
        }

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => columnService.sortColumn(column.identifier),
            child: column.sortOrder == SortOrder.none
                ? const SizedBox.shrink()
                : column.sortOrder == SortOrder.descending
                    ? tableConfigurationNotifier.currentState.columnConfiguration.sortDescendingIconBuilder(identifier)
                    : tableConfigurationNotifier.currentState.columnConfiguration.sortAscendingIconBuilder(identifier),
          ),
        );
      },
    );
  }

  Widget _resizeIcon(BuildContext context) {
    return Consumer3<TableConfigurationNotifier, ColumnStateNotifier, ColumnService>(
      builder: (context, tableConfigurationNotifier, columnStateNotifier, columnService, child) {
        var column = columnStateNotifier.currentState.firstWhere((element) => element.identifier == identifier);

        if (tableConfigurationNotifier.currentState.columnConfiguration.canResizeBuilder(identifier) == false) {
          return const SizedBox.shrink();
        }

        return MouseRegion(
          cursor: SystemMouseCursors.resizeColumn,
          child: GestureDetector(
            onTap: () {},
            onHorizontalDragUpdate: (details) => columnService.updateColumnWidth(column, details.delta.dx),
            child: const Icon(
              LucideIcons.gripVertical,
              size: 16,
            ),
          ),
        );
      },
    );
  }
}
