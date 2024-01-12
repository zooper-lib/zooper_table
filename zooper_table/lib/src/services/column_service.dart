import 'package:zooper_table/zooper_table.dart';

class ColumnService {
  final RowService rowService;

  final TableConfigurationNotifier tableConfigNotifier;
  final ColumnStateNotifier columnStateNotifier;

  final TableState tableState;

  ColumnService({
    required this.rowService,
    required this.tableConfigNotifier,
    required this.columnStateNotifier,
    required this.tableState,
  });

  double getColumnWidth(String identifier) {
    var actualWith = tableState.currentState.columnWidths[identifier]!;

    var minWidth = tableConfigNotifier.currentState.columnConfiguration.minWidthBuilder(identifier);
    var maxWidth = tableConfigNotifier.currentState.columnConfiguration.maxWidthBuilder(identifier);

    return actualWith.clamp(minWidth, maxWidth);
  }

  void updateColumnWidth(String identifier, double delta) {
    final double minWidth = tableConfigNotifier.currentState.columnConfiguration.minWidthBuilder(identifier);
    final double maxWidth = tableConfigNotifier.currentState.columnConfiguration.maxWidthBuilder(identifier);

    final tableStateSnapshot = tableState.currentState;

    tableStateSnapshot.columnWidths[identifier] =
        (tableStateSnapshot.columnWidths[identifier]! + delta).clamp(minWidth, maxWidth);

    tableState.updateState(tableStateSnapshot);
  }

  void sortColumn(String identifier) {
    // Check if the column can be sorted
    if (!tableConfigNotifier.currentState.columnConfiguration.canSortBuilder(identifier)) {
      return;
    }

    var tableStateSnapshot = tableState.currentState;

    tableStateSnapshot.primaryColumnSort = tableStateSnapshot.primaryColumnSort?.sortOrder == null
        ? ColumnSort(identifier: identifier, sortOrder: SortOrder.descending)
        : tableStateSnapshot.primaryColumnSort?.sortOrder == SortOrder.descending
            ? ColumnSort(identifier: identifier, sortOrder: SortOrder.ascending)
            : null;

    tableState.updateState(tableStateSnapshot);

    // Update the rows
    rowService.setNeedsUpdate();
  }
}
