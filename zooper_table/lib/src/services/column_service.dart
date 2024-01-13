import 'package:zooper_table/zooper_table.dart';

class ColumnService {
  final TableConfigurationNotifier tableConfigNotifier;
  final ColumnState columnState;

  final TableState tableState;

  ColumnService({
    required this.tableConfigNotifier,
    required this.columnState,
    required this.tableState,
  });

  int getColumnIndexByIdentifier(String identifier) {
    var allColumns = columnState.currentState;

    return allColumns.indexWhere((element) => element.identifier == identifier);
  }

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

    final double newWidth = (tableStateSnapshot.columnWidths[identifier]! + delta).clamp(minWidth, maxWidth);

    tableStateSnapshot.columnWidths[identifier] = newWidth;

    tableState.updateState(tableStateSnapshot);
  }

  void sortColumn(String identifier) {
    // Check if the column can be sorted
    if (!tableConfigNotifier.currentState.columnConfiguration.canSortBuilder(identifier)) {
      return;
    }

    var tableStateSnapshot = tableState.currentState;

    tableStateSnapshot.primaryColumnSort = tableStateSnapshot.primaryColumnSort?.sortOrder == null
        ? ColumnSort(identifier: identifier, sortOrder: SortOrder.ascending)
        : tableStateSnapshot.primaryColumnSort?.sortOrder == SortOrder.ascending
            ? ColumnSort(identifier: identifier, sortOrder: SortOrder.descending)
            : null;

    tableState.updateState(tableStateSnapshot);
  }

  bool isAnyColumnSorted() {
    return tableState.currentState.primaryColumnSort != null || tableState.currentState.secondaryColumnSort != null;
  }

  void reorderColumn(int oldIndex, int newIndex) {
    var columnSnapshot = columnState.currentState;

    // Get the column which should be reordered
    var column = columnSnapshot[oldIndex];

    // Remove the column from the list
    columnSnapshot.removeAt(oldIndex);

    // Adjusting newIndex when dragging downwards
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    // Add the column to the new index
    columnSnapshot.insert(newIndex, column);

    // Update all columns
    columnState.updateAllColumns(columnSnapshot);

    // Call the callback
    tableConfigNotifier.currentState.callbackConfiguration.onColumnReorder?.call(column.identifier, oldIndex, newIndex);
  }

  bool canResize(String columnIdentifier) {
    return tableConfigNotifier.currentState.columnConfiguration.canResizeBuilder(columnIdentifier);
  }
}
