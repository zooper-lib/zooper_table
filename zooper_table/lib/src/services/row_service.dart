import 'package:zooper_table/zooper_table.dart';

class RowService {
  final TableConfigurationNotifier tableConfigNotifier;
  final DataStateNotifier dataStateNotifier;
  final ColumnStateNotifier columnStateNotifier;
  final RowState rowStateNotifier;

  final TableState tableState;

  RowService({
    required this.tableConfigNotifier,
    required this.dataStateNotifier,
    required this.columnStateNotifier,
    required this.rowStateNotifier,
    required this.tableState,
  });

  double? getRowHeight(String rowIdentifier, int index) {
    return tableConfigNotifier.currentState.rowConfiguration.heightBuilder.call(rowIdentifier, index);
  }

  List<RowData> getSortedRows() {
    // Generate a new List from the current state, else we will edit the existing one
    List<RowData> sortedRows = List.from(rowStateNotifier.currentState);

    // If the primary sort order is null, there is no sorting and we directly return the list
    if (tableState.currentState.primaryColumnSort == null) {
      return sortedRows;
    }

    sortedRows.sort((a, b) {
      var valueA = tableConfigNotifier.currentState.valueGetter(
        a.data,
        tableState.currentState.primaryColumnSort!.identifier,
      );
      var valueB = tableConfigNotifier.currentState.valueGetter(
        b.data,
        tableState.currentState.primaryColumnSort!.identifier,
      );

      // TODO: Use a custom Sorter which can be provided by the User
      var compare = valueA.compareTo(valueB);

      return tableState.currentState.primaryColumnSort?.sortOrder == SortOrder.ascending ? compare : -compare;
    });

    return sortedRows;
  }

  bool isReorderingEnabled() {
    var tableData = tableState.currentState;

    if (tableData.primaryColumnSort != null || tableData.secondaryColumnSort != null) {
      return false;
    }

    return tableConfigNotifier.currentState.rowConfiguration.isReorderingEnabledBuilder.call();
  }

  void reorderRow(int oldIndex, int newIndex) {
    var rowSnapshot = rowStateNotifier.currentState;

    // Get the row which should be reordered
    var row = rowSnapshot[oldIndex];

    // Remove the row from the list
    rowSnapshot.removeAt(oldIndex);

    // Add the row to the new index
    rowSnapshot.insert(newIndex, row);

    // Update all rows
    rowStateNotifier.updateRowList(rowSnapshot);
  }

  void setNeedsUpdate() {
    rowStateNotifier.setNeedsUpdate();
  }
}
