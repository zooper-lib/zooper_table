import 'package:zooper_table/zooper_table.dart';

class ColumnHelper {
  final TableConfigurationNotifier _tableConfigurationNotifier;
  final ColumnStateNotifier _columnStateNotifier;

  ColumnHelper(
    this._tableConfigurationNotifier,
    this._columnStateNotifier,
  );

  List<ZooperColumnView> buildColumns() {
    var columnHeaderItems = <ZooperColumnView>[];

    for (final column in _columnStateNotifier.columns) {
      final columnHeaderItemView = buildColumnItem(
        column,
        _tableConfigurationNotifier.tableConfiguration.columnHeaderConfiguration,
      );
      columnHeaderItems.add(columnHeaderItemView);
    }

    return columnHeaderItems;
  }

  ZooperColumnView buildColumnItem(
    ZooperColumnModel columnModel,
    ColumnConfiguration columnConfiguration,
  ) {
    return ZooperColumnView(
      model: columnModel,
      columnConfiguration: columnConfiguration,
    );
  }
}
