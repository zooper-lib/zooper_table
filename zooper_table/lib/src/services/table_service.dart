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
    // Split columns into sticky and normal
    var leftStickyColumns = columns.where((c) => c.columnStick == ColumnStick.left).map((c) => c.identifier).toList();
    var rightStickyColumns = columns.where((c) => c.columnStick == ColumnStick.right).map((c) => c.identifier).toList();
    var normalColumns = columns.where((c) => c.columnStick == ColumnStick.center).map((c) => c.identifier).toList();

    // Order each group separately
    var orderedLeftSticky = leftStickyColumns.where((c) => initialColumnOrder.contains(c)).toList();
    var orderedRightSticky = rightStickyColumns.where((c) => initialColumnOrder.contains(c)).toList();
    var orderedNormal = [
      ...initialColumnOrder.where((c) => normalColumns.contains(c)),
      ...normalColumns.where((c) => !initialColumnOrder.contains(c))
    ];

    // Combine them
    return [...orderedLeftSticky, ...orderedNormal, ...orderedRightSticky];
  }

  static List<String> _reinitializeTableData(
    List<String> existingColumnOrder,
    List<String> initialColumnOrder,
    List<ColumnData> columns,
  ) {
    // Similar logic to _createDataColumnOrder but for existing data
    var leftStickyColumns = columns.where((c) => c.columnStick == ColumnStick.left).map((c) => c.identifier).toList();
    var rightStickyColumns = columns.where((c) => c.columnStick == ColumnStick.right).map((c) => c.identifier).toList();
    var normalColumns = columns.where((c) => c.columnStick == ColumnStick.center).map((c) => c.identifier).toList();

    // Handle sticky columns separately
    var newLeftStickyOrder = existingColumnOrder.where((c) => leftStickyColumns.contains(c)).toList();
    var newRightStickyOrder = existingColumnOrder.where((c) => rightStickyColumns.contains(c)).toList();

    // Handle normal columns
    var newNormalOrder = existingColumnOrder.where((c) => normalColumns.contains(c)).toList();
    newNormalOrder
        .addAll(initialColumnOrder.where((c) => !existingColumnOrder.contains(c) && normalColumns.contains(c)));

    // Remove non-existent columns
    newNormalOrder.removeWhere((c) => !columns.any((element) => element.identifier == c));

    return [...newLeftStickyOrder, ...newNormalOrder, ...newRightStickyOrder];
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
}
