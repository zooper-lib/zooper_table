import 'package:zooper_table/zooper_table.dart';

class RowService {
  final TableConfigurationNotifier tableConfigNotifier;
  final DataStateNotifier dataStateNotifier;
  final ColumnState columnStateNotifier;
  final RowState rowState;

  final TableState tableState;

  RowService({
    required this.tableConfigNotifier,
    required this.dataStateNotifier,
    required this.columnStateNotifier,
    required this.rowState,
    required this.tableState,
  });

  dynamic getDataByIndex(int index) {
    return dataStateNotifier.currentState[index];
  }

  double? getRowHeight(String rowIdentifier, int index) {
    return tableConfigNotifier.currentState.rowConfiguration.heightBuilder(rowIdentifier, index);
  }

  List<RowData> getSortedRows() {
    // Generate a new List from the current state, else we will edit the existing one
    List<RowData> rowSnapshot = List.from(rowState.currentState);

    // If the primary sort order is null, there is no sorting and we directly return the list
    if (tableState.currentState.primaryColumnSort == null) {
      return rowSnapshot;
    }

    rowSnapshot.sort((a, b) {
      final primaryValueA = tableConfigNotifier.currentState.valueGetter(
        a.data,
        tableState.currentState.primaryColumnSort!.identifier,
      );
      final primaryValueB = tableConfigNotifier.currentState.valueGetter(
        b.data,
        tableState.currentState.primaryColumnSort!.identifier,
      );

      // TODO: Use a custom Sorter which can be provided by the User
      final primaryCompare = primaryValueA.compareTo(primaryValueB);

      if (primaryCompare != 0) {
        return tableState.currentState.primaryColumnSort?.sortOrder == SortOrder.ascending
            ? primaryCompare
            : -primaryCompare;
      }

      if (tableState.currentState.secondaryColumnSort == null) {
        return 0;
      }

      final secondaryValueA = tableConfigNotifier.currentState.valueGetter(
        a.data,
        tableState.currentState.secondaryColumnSort!.identifier,
      );

      final secondaryValueB = tableConfigNotifier.currentState.valueGetter(
        b.data,
        tableState.currentState.secondaryColumnSort!.identifier,
      );

      final secondaryCompare = secondaryValueA.compareTo(secondaryValueB);

      return tableState.currentState.secondaryColumnSort?.sortOrder == SortOrder.ascending
          ? secondaryCompare
          : -secondaryCompare;
    });

    return rowSnapshot;
  }

  bool isReorderingEnabled() {
    var tableData = tableState.currentState;

    if (tableData.primaryColumnSort != null || tableData.secondaryColumnSort != null) {
      return false;
    }

    return tableConfigNotifier.currentState.rowConfiguration.rowDragConfiguration.isReorderingEnabledBuilder();
  }

  void reorderRow(int oldIndex, int newIndex) {
    var rowSnapshot = rowState.currentState;

    // Get the row which should be reordered
    var row = rowSnapshot[oldIndex];

    // Remove the row from the list
    rowSnapshot.removeAt(oldIndex);

    // Adjusting newIndex when dragging downwards
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    // Add the row to the new index
    rowSnapshot.insert(newIndex, row);

    // Update all rows
    rowState.updateRowList(rowSnapshot);

    // Call the callback
    tableConfigNotifier.currentState.callbackConfiguration.onRowReorder?.call(rowSnapshot, oldIndex, newIndex);
  }

  void setNeedsUpdate() {
    rowState.setNeedsUpdate();
  }

  void onRowTap(RowData row) {
    // Unselect all rows
    for (var row in rowState.currentState) {
      row.isSelected = false;
    }

    // Set the Row as selected
    row.isSelected = true;

    // Update the Row
    rowState.updateRow(row);

    // Get the index of the row
    var index = rowState.currentState.indexOf(row);

    // Call the callback
    tableConfigNotifier.currentState.callbackConfiguration.onRowSelected?.call(row, index);
  }
}
