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

  int getAbsoluteColumnIndexByIdentifier(String identifier) {
    var allColumns = columnState.dataColumns;

    return allColumns.indexWhere((element) => element.identifier == identifier);
  }

  int getRelativeColumnIndexByIdentifier(String identifier) {
    var allColumns = columnState.dataColumns;

    var column = allColumns.firstWhere((element) => element.identifier == identifier);

    final absoluteIndex = allColumns.indexWhere((element) => element.identifier == identifier);

    if (column.columnStick == ColumnStick.left) {
      return absoluteIndex;
    }

    if (column.columnStick == ColumnStick.center) {
      return absoluteIndex - getColumnCountByStick(ColumnStick.left);
    }

    if (column.columnStick == ColumnStick.right) {
      return absoluteIndex - getColumnCountByStick(ColumnStick.left) - getColumnCountByStick(ColumnStick.center);
    }

    return 0;
  }

  List<ColumnData> getColumnListByStick(ColumnStick columnStick) {
    var allColumns = columnState.dataColumns;

    return allColumns.where((element) => element.columnStick == columnStick).toList();
  }

  double getColumnWidthByStick(ColumnStick columnStick) {
    var allColumns = columnState.dataColumns;

    var filteredColumn = allColumns.where((element) => element.columnStick == columnStick);

    if (filteredColumn.isEmpty) {
      return 0;
    }

    return filteredColumn.map((e) => getColumnWidth(e.identifier)).reduce((value, element) => value + element);
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

    // Call the callback
    tableConfigNotifier.currentState.callbackConfiguration.onColumnSort
        ?.call(identifier, tableStateSnapshot.primaryColumnSort?.sortOrder);
  }

  bool isAnyColumnSorted() {
    return tableState.currentState.primaryColumnSort != null || tableState.currentState.secondaryColumnSort != null;
  }

  void reorderColumn(ColumnStick columnStick, int oldIndex, int newIndex) {
    // Get the list of columns by stick
    var columnListByStick = getColumnListByStick(columnStick);

    // Get all columns without the stick
    var columnSnapshotWithoutStick = getColumnListWithoutStick(columnState.dataColumns, columnStick);

    // Get the list of columns that are reordered
    final reorderedColumnList = getReorderedColumnList(columnListByStick, oldIndex, newIndex);

    // Merge the list back together
    final mergedColumnList = [...columnSnapshotWithoutStick, ...reorderedColumnList];

    // Update all columns
    columnState.updateAllDataColumns(mergedColumnList);

    // Call the callback
    tableConfigNotifier.currentState.callbackConfiguration.onColumnReorder
        ?.call(columnListByStick[oldIndex].identifier, oldIndex, newIndex);
  }

  List<ColumnData> getReorderedColumnList(List<ColumnData> columnList, int oldIndex, int newIndex) {
    // Get the column that is being dragged
    var sourceColumn = columnList[oldIndex];

    // Remove the column from the list
    columnList.removeAt(oldIndex);

    // Adjusting newIndex when dragging downwards
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    // Add the column to the new index
    columnList.insert(newIndex, sourceColumn);

    return columnList;
  }

  List<ColumnData> getColumnListWithoutStick(List<ColumnData> columns, ColumnStick columnStick) {
    return columns.where((element) => element.columnStick != columnStick).toList();
  }

  int getColumnCountByStick(ColumnStick columnStick) {
    return columnState.dataColumns.where((element) => element.columnStick == columnStick).length;
  }

  bool canResize(String columnIdentifier) {
    return tableConfigNotifier.currentState.columnConfiguration.canResizeBuilder(columnIdentifier);
  }
}
