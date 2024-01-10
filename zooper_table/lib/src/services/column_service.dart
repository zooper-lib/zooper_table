import 'package:zooper_table/zooper_table.dart';

class ColumnService {
  final TableConfigurationNotifier tableConfigNotifier;
  final ColumnStateNotifier columnStateNotifier;

  ColumnService({
    required this.tableConfigNotifier,
    required this.columnStateNotifier,
  });

  void updateColumnWidth(ZooperColumnModel model, double delta) {
    final double minWidth =
        tableConfigNotifier.currentState.columnHeaderConfiguration.minWidthBuilder(model.identifier);
    final double maxWidth =
        tableConfigNotifier.currentState.columnHeaderConfiguration.maxWidthBuilder(model.identifier);

    model.width = (model.width + delta).clamp(minWidth, maxWidth);

    columnStateNotifier.updateColumn(model);
  }

  List<ZooperColumnView> buildColumnViewList() {
    var columnHeaderItems = <ZooperColumnView>[];

    for (final column in columnStateNotifier.currentState) {
      final columnHeaderItemView = buildColumnItem(
        column,
        tableConfigNotifier.currentState.columnHeaderConfiguration,
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
