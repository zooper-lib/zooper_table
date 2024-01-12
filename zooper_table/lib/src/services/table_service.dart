import 'package:zooper_table/zooper_table.dart';

class TableService {
  static TableData initializeTable(
    TableData? initialTableData,
    List<String> initialColumnOrder,
    List<ZooperColumnModel> columns,
    ColumnSort? primaryColumnSort,
    ColumnSort? secondaryColumnSort,
  ) {
    if (initialTableData != null) {
      return _reinitializeTableData(initialTableData, initialColumnOrder, columns);
    }

    // Create the column order based on the initial order and the columns that are not in the initial order.
    // The List is created like this:
    // 1. Add all columns that are in the initial order
    // 2. Add all columns that are not in the initial order
    final columnOrder = [
      ...initialColumnOrder,
      ...columns.where((column) => !initialColumnOrder.contains(column.identifier)).map((column) => column.identifier)
    ];

    // Create the TableData
    final tableData = TableData(
      columnOrder: columnOrder,
      primaryColumnSort: primaryColumnSort,
      secondaryColumnSort: secondaryColumnSort,
    );

    return tableData;
  }

  static TableData _reinitializeTableData(
    TableData tableData,
    List<String> columnOrder,
    List<ZooperColumnModel> columns,
  ) {
    // Get all column identifiers which are new
    final newColumnIdentifiers = columnOrder.where((identifier) => !tableData.columnOrder.contains(identifier));

    // Construct the new column order
    final newColumnOrder = [...tableData.columnOrder, ...newColumnIdentifiers];

    // Remove all non existent column order identifiers
    newColumnOrder.removeWhere((identifier) => !columns.any((element) => element.identifier == identifier));

    // Update the table data
    tableData.columnOrder = newColumnOrder;

    return tableData;
  }

  void sortColumn(String identifier) {}

  /* void reorderRow(int oldIndex, int newIndex) {
    var rowSnapshot = rowStateNotifier.currentState;

    // Find the row being moved.
    final movedRow = rowSnapshot.firstWhere((row) => row.order == oldIndex);

    // Update the order of the moved row.
    movedRow.order = newIndex;

    // Adjust the order of other rows.
    if (oldIndex < newIndex) {
      for (final row in rowSnapshot) {
        if (row.order > oldIndex && row.order <= newIndex) {
          row.order--;
        }
      }
    } else {
      for (final row in rowSnapshot) {
        if (row.order < oldIndex && row.order >= newIndex) {
          row.order++;
        }
      }
    }

    // Update all rows
    rowStateNotifier.updateRowList(rowSnapshot);
  } */
}
