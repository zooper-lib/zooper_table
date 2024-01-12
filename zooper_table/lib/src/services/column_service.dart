import 'package:zooper_table/zooper_table.dart';

class ColumnService {
  final TableConfigurationNotifier tableConfigNotifier;
  final ColumnStateNotifier columnStateNotifier;
  final RowStateNotifier rowStateNotifier;

  ColumnService({
    required this.tableConfigNotifier,
    required this.columnStateNotifier,
    required this.rowStateNotifier,
  });

  void updateColumnWidth(ZooperColumnModel model, double delta) {
    final double minWidth = tableConfigNotifier.currentState.columnConfiguration.minWidthBuilder(model.identifier);
    final double maxWidth = tableConfigNotifier.currentState.columnConfiguration.maxWidthBuilder(model.identifier);

    //var updatedModel = model.copyWith(width: (model.width + delta).clamp(minWidth, maxWidth));
    model.width = (model.width + delta).clamp(minWidth, maxWidth);

    columnStateNotifier.updateColumn(model);
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

    List<ZooperRowModel> updatedRowModels = rowStateNotifier.currentState;

    if (newSortOrder == SortOrder.none) {
      updatedRowModels.sort((a, b) => a.order.compareTo(b.order));
    } else {
      updatedRowModels.sort((a, b) {
        var valueA = tableConfigNotifier.currentState.valueGetter(a.data, identifier);
        var valueB = tableConfigNotifier.currentState.valueGetter(b.data, identifier);
        var compare = valueA.compareTo(valueB);
        return newSortOrder == SortOrder.ascending ? compare : -compare;
      });
    }

    // Update all rows
    rowStateNotifier.updateRowList(updatedRowModels);
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
