import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zooper_table/zooper_table.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ZooperColumnView extends StatelessWidget {
  final String identifier;

  const ZooperColumnView({
    super.key,
    required this.identifier,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final columnConfiguration = ref.watch(tableConfigurationProvider).columnHeaderConfiguration;
        final columnStateNotifier = ref.watch(columnStateProvider.notifier);

        var column = ref.watch(columnStateProvider).firstWhere((element) => element.identifier == identifier);
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
                Expanded(
                  child: Text(
                    column.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //const SizedBox.expand(),
                _resizeIcon(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _resizeIcon(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var columnService = ref.watch(columnServiceProvider);
        var column = ref.watch(columnStateProvider).firstWhere((element) => element.identifier == identifier);

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
