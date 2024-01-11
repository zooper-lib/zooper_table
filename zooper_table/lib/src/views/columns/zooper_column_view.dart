import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zooper_table/zooper_table.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ZooperColumnView extends StatelessWidget {
  final String identifier;

  ZooperColumnView({
    required this.identifier,
  }) : super(key: ValueKey('column:$identifier'));

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final columnConfiguration = ref.watch(tableConfigurationProvider).columnHeaderConfiguration;
        final columnStateNotifier = ref.watch(columnStateProvider.notifier);

        var columnIndex = ref.watch(columnStateProvider).indexWhere((element) => element.identifier == identifier);

        final double minWidth = columnConfiguration.minWidthBuilder(identifier);
        final double maxWidth = columnConfiguration.maxWidthBuilder(identifier);

        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minWidth,
            maxWidth: maxWidth,
          ),
          child: Container(
            width: columnStateNotifier.currentState.firstWhere((element) => element.identifier == identifier).width,
            padding: columnConfiguration.paddingBuilder(identifier),
            decoration: BoxDecoration(
              border: columnConfiguration.borderBuilder(identifier, columnIndex),
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
    return Consumer(
      builder: (context, ref, child) {
        var columnService = ref.watch(columnServiceProvider);
        var column = ref.watch(columnStateProvider).firstWhere((element) => element.identifier == identifier);

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
    return Consumer(
      builder: (context, ref, child) {
        final columnConfiguration = ref.watch(tableConfigurationProvider).columnHeaderConfiguration;
        final columnService = ref.watch(columnServiceProvider);
        final columnStateNotifier = ref.watch(columnStateProvider.notifier);
        final column = columnStateNotifier.currentState.firstWhere((element) => element.identifier == identifier);

        if (columnConfiguration.canSortBuilder(identifier) == false) {
          return const SizedBox.shrink();
        }

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => columnService.sortColumn(column.identifier),
            child: column.sortOrder == SortOrder.none
                ? const SizedBox.shrink()
                : column.sortOrder == SortOrder.descending
                    ? columnConfiguration.sortDescendingIconBuilder(identifier)
                    : columnConfiguration.sortAscendingIconBuilder(identifier),
          ),
        );
      },
    );
  }

  Widget _resizeIcon(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final columnConfiguration = ref.watch(tableConfigurationProvider).columnHeaderConfiguration;
        var columnService = ref.watch(columnServiceProvider);
        var column = ref.watch(columnStateProvider).firstWhere((element) => element.identifier == identifier);

        if (columnConfiguration.canResizeBuilder(identifier) == false) {
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
