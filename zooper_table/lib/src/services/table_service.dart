import 'package:zooper_table/zooper_table.dart';

class TableService {
  static TableData initializeTable(
    TableConfiguration tableConfiguration,
    TableData? initialTableData,
    List<String> initialColumnOrder,
    List<ColumnData> columns,
    ColumnSort? primaryColumnSort,
    ColumnSort? secondaryColumnSort,
  ) {
    var columnOrder = initialTableData != null
        ? _reinitializeTableData(initialTableData.columnOrder, initialColumnOrder, columns)
        : _createColumnOrder(initialColumnOrder, columns);

    final columnWidths = _initializeColumnWidths(tableConfiguration, initialTableData, columns);

    // Create the TableData
    final tableData = TableData(
      columnOrder: columnOrder,
      primaryColumnSort: primaryColumnSort,
      secondaryColumnSort: secondaryColumnSort,
      columnWidths: columnWidths,
    );

    return tableData;
  }

  static List<String> _createColumnOrder(List<String> initialColumnOrder, List<ColumnData> columns) {
    // Create the column order based on the initial order and the columns that are not in the initial order.
    // The List is created like this:
    // 1. Add all columns that are in the initial order
    // 2. Add all columns that are not in the initial order
    final columnOrder = [
      ...initialColumnOrder,
      ...columns.where((column) => !initialColumnOrder.contains(column.identifier)).map((column) => column.identifier)
    ];

    return columnOrder;
  }

  static List<String> _reinitializeTableData(
    List<String> existingColumnOrder,
    List<String> initialColumnOrder,
    List<ColumnData> columns,
  ) {
    // Get all column identifiers which are new
    final newColumnIdentifiers = initialColumnOrder.where((identifier) => !existingColumnOrder.contains(identifier));

    // Construct the new column order
    final newColumnOrder = [...existingColumnOrder, ...newColumnIdentifiers];

    // Remove all non existent column order identifiers
    newColumnOrder.removeWhere((identifier) => !columns.any((element) => element.identifier == identifier));

    // Update the table data
    return newColumnOrder;
  }

  static Map<String, double> _initializeColumnWidths(
      TableConfiguration tableConfiguration, TableData? initialTableData, List<ColumnData> columns) {
    final Map<String, double> columnWidths = {};

    // Add the widths based on the initial table data
    if (initialTableData != null) {
      columnWidths.addAll(initialTableData.columnWidths);
    }

    // Get the columns which are not present in the column width Map
    final columnsWithoutWidth = columns.where((column) => !columnWidths.containsKey(column.identifier));

    // Add the widths based on the column configuration
    for (final column in columnsWithoutWidth) {
      columnWidths[column.identifier] = tableConfiguration.columnConfiguration.initialWidthBuilder(column.identifier);
    }

    return columnWidths;
  }

  void sortColumn(String identifier) {}
}
