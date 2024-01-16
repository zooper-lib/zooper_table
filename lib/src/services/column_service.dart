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

  /// Returns the overall width of the table.
  double getOverallWidth() {
    final dragHandleWidth =
        tableConfigNotifier.currentState.rowConfiguration.rowDragConfiguration.widthBuilder(0, null);

    var allColumns = columnState.dataColumns;

    return allColumns.map((e) => getColumnWidth(e.identifier)).reduce((value, element) => value + element) +
        (dragHandleWidth ?? 0);
  }

  void updateColumnWidth(String identifier, double delta) {
    final double minWidth = tableConfigNotifier.currentState.columnConfiguration.minWidthBuilder(identifier);
    final double maxWidth = tableConfigNotifier.currentState.columnConfiguration.maxWidthBuilder(identifier);

    final tableStateSnapshot = tableState.currentState;

    final double newWidth = (tableStateSnapshot.columnWidths[identifier]! + delta).clamp(minWidth, maxWidth);

    tableStateSnapshot.columnWidths[identifier] = newWidth;

    tableState.updateState(tableStateSnapshot);
  }

  void sortColumn(String identifier, bool secondarySort) {
    // Check if the column can be sorted
    if (!tableConfigNotifier.currentState.columnConfiguration.canSortBuilder(identifier)) {
      return;
    }

    // Sort the column
    var tableStateSnapshot = (secondarySort)
        ? _secondarySortColumn(identifier, tableState.currentState)
        : _primarySortColumn(identifier, tableState.currentState);

    // Update the state
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

  TableData _primarySortColumn(String identifier, TableData tableData) {
    // If an other column is previously sorted, start sorting from beginning
    if (tableData.primaryColumnSort?.identifier != identifier) {
      tableData.primaryColumnSort = ColumnSort(identifier: identifier, sortOrder: SortOrder.ascending);

      // Also set the secondary sort to null
      tableData.secondaryColumnSort = null;
    } else {
      tableData.primaryColumnSort = tableData.primaryColumnSort?.sortOrder == null
          ? ColumnSort(identifier: identifier, sortOrder: SortOrder.ascending)
          : tableData.primaryColumnSort?.sortOrder == SortOrder.ascending
              ? ColumnSort(identifier: identifier, sortOrder: SortOrder.descending)
              : null;
    }

    return tableData;
  }

  TableData _secondarySortColumn(String identifier, TableData tableData) {
    if (tableData.secondaryColumnSort?.identifier != identifier) {
      tableData.secondaryColumnSort = ColumnSort(identifier: identifier, sortOrder: SortOrder.ascending);
    } else {
      tableData.secondaryColumnSort = tableData.secondaryColumnSort?.sortOrder == null
          ? ColumnSort(identifier: identifier, sortOrder: SortOrder.ascending)
          : tableData.secondaryColumnSort?.sortOrder == SortOrder.ascending
              ? ColumnSort(identifier: identifier, sortOrder: SortOrder.descending)
              : null;
    }

    return tableData;
  }
}
