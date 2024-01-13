import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class RowDragHandleView extends StatelessWidget {
  final int rowIndex;

  const RowDragHandleView({
    super.key,
    required this.rowIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer3<TableConfigurationNotifier, ColumnService, RowService>(
      builder: (context, tableConfigurationNotifier, columnService, rowService, child) {
        final isRowDragHandleEnabled = tableConfigurationNotifier.currentState.rowConfiguration.rowDragConfiguration
            .isRowDragHandleEnabledBuilder(rowIndex);
        final isReorderingEnabled =
            tableConfigurationNotifier.currentState.rowConfiguration.rowDragConfiguration.isReorderingEnabledBuilder();
        final isAnyColumnSorted = columnService.isAnyColumnSorted();

        if (!isRowDragHandleEnabled || !isReorderingEnabled) {
          return const SizedBox.shrink();
        }

        final rowDragHandle = tableConfigurationNotifier.currentState.rowConfiguration.rowDragConfiguration
            .rowDragHandleBuilder(rowIndex);

        final data = rowService.getDataByIndex(rowIndex);

        return Container(
          padding: tableConfigurationNotifier.currentState.rowConfiguration.rowDragConfiguration.paddingBuilder(
            rowIndex,
            data,
          ),
          width: tableConfigurationNotifier.currentState.rowConfiguration.rowDragConfiguration.widthBuilder(
            rowIndex,
            data,
          ),
          child: isAnyColumnSorted
              ? null
              : MouseRegion(
                  cursor: SystemMouseCursors.grab,
                  child: ReorderableDragStartListener(
                    index: rowIndex,
                    child: rowDragHandle,
                  ),
                ),
        );
      },
    );
  }
}
