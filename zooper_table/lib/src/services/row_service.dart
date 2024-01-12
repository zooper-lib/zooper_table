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

  void sortRows() {
    List<ZooperRowModel> updatedRowModels = rowStateNotifier.currentState;

    if (tableState.currentState.primaryColumnSort?.sortOrder == null) {
      updatedRowModels.sort((a, b) => a.order.compareTo(b.order));
    } else {
      updatedRowModels.sort((a, b) {
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
    }

    // Update the rows
    rowStateNotifier.updateRowList(updatedRowModels);
  }

  bool isReorderingEnabled() {
    var tableData = tableState.currentState;

    if (tableData.primaryColumnSort != null || tableData.secondaryColumnSort != null) {
      return false;
    }

    return tableConfigNotifier.currentState.rowConfiguration.isReorderingEnabledBuilder.call();
  }
}
