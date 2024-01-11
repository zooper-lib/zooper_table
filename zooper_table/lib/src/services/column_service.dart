import 'package:zooper_table/zooper_table.dart';

class ColumnService {
  final TableConfigurationNotifier tableConfigNotifier;
  final ColumnStateNotifier columnStateNotifier;
  final DataStateNotifier dataStateNotifier;

  ColumnService({
    required this.tableConfigNotifier,
    required this.columnStateNotifier,
    required this.dataStateNotifier,
  });

  void updateColumnWidth(ZooperColumnModel model, double delta) {
    final double minWidth = tableConfigNotifier.currentState.columnConfiguration.minWidthBuilder(model.identifier);
    final double maxWidth = tableConfigNotifier.currentState.columnConfiguration.maxWidthBuilder(model.identifier);

    var updatedModel = model.copyWith(width: (model.width + delta).clamp(minWidth, maxWidth));

    columnStateNotifier.updateColumn(updatedModel);
  }

  void sortColumn(String identifier) {
    // Check if the column can be sorted
    if (!tableConfigNotifier.currentState.columnConfiguration.canSortBuilder(identifier)) {
      return;
    }

    // Get all columns and set their sort order to null
    List<ZooperColumnModel> updatedColumns = [];
    SortOrder? newSortOrder;

    for (var column in columnStateNotifier.currentState) {
      if (column.identifier == identifier) {
        newSortOrder = column.sortOrder == SortOrder.none
            ? SortOrder.descending
            : column.sortOrder == SortOrder.descending
                ? SortOrder.ascending
                : SortOrder.none;
        updatedColumns.add(column.copyWith(sortOrder: newSortOrder));
      } else {
        updatedColumns.add(column.copyWith(sortOrder: SortOrder.none));
      }
    }

    // Update all columns
    columnStateNotifier.updateAllColumns(updatedColumns);

    // Sort the rows based on the sorted columns
    List<dynamic> updatedRows = dataStateNotifier.currentState;
    updatedRows.sort((a, b) {
      var valueA = tableConfigNotifier.currentState.valueGetter(a, identifier);
      var valueB = tableConfigNotifier.currentState.valueGetter(b, identifier);
      var compare = valueA.compareTo(valueB);
      return newSortOrder == SortOrder.ascending ? compare : -compare;
    });

    // Update all rows
    dataStateNotifier.updateAllData(updatedRows);
  }

  List<ZooperColumnView> buildColumnViewList() {
    var columnHeaderItems = <ZooperColumnView>[];

    for (final column in columnStateNotifier.currentState) {
      final columnHeaderItemView = buildColumnItem(
        column,
        tableConfigNotifier.currentState.columnConfiguration,
      );
      columnHeaderItems.add(columnHeaderItemView);
    }

    return columnHeaderItems;
  }

  ZooperColumnView buildColumnItem(
    ZooperColumnModel columnModel,
    ColumnConfiguration columnConfiguration,
  ) {
    return ZooperColumnView(identifier: columnModel.identifier);
  }
}
