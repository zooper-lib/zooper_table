import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ResizeHandleView extends StatelessWidget {
  final String columnIdentifier;

  const ResizeHandleView({
    super.key,
    required this.columnIdentifier,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<TableState, ColumnService>(
      builder: (context, tableState, columnService, child) {
        if (columnService.canResize(columnIdentifier) == false) {
          return const SizedBox.shrink();
        }

        return MouseRegion(
          cursor: SystemMouseCursors.resizeColumn,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            onHorizontalDragUpdate: (details) => columnService.updateColumnWidth(columnIdentifier, details.delta.dx),
            child: Container(
              width: 4,
            ),
          ),
        );
      },
    );
  }
}
