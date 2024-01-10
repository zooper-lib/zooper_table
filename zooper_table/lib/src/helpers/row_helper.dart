import 'package:zooper_table/zooper_table.dart';

class RowHelper<TData> {
  final ColumnStateNotifier _columnStateNotifier;
  final DataStateNotifier _dataStateNotifier;
  final TableConfigurationNotifier<TData> _tableConfigurationNotifier;

  RowHelper(
    this._columnStateNotifier,
    this._dataStateNotifier,
    this._tableConfigurationNotifier,
  );

  List<ZooperRowView> buildRows() {
    var rows = <ZooperRowView>[];

    for (int i = 0; i < _dataStateNotifier.data.length; i++) {
      final row = _buildRow(_dataStateNotifier.data[i], i);
      rows.add(row);
    }

    return rows;
  }

  ZooperRowView _buildRow(TData data, int index) {
    final configuration = _tableConfigurationNotifier.tableConfiguration.rowConfiguration;

    return ZooperRowView<TData>(
      rowConfiguration: configuration,
      cellConfiguration: _tableConfigurationNotifier.tableConfiguration.cellConfiguration,
      columns: _columnStateNotifier.columns,
      data: data,
      index: index,
    );
  }
}
