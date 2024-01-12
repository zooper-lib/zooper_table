import 'package:zooper_table/zooper_table.dart';

class RowService {
  final TableConfigurationNotifier tableConfigNotifier;
  final DataStateNotifier dataStateNotifier;
  final ColumnStateNotifier columnStateNotifier;
  final RowStateNotifier rowStateNotifier;

  RowService({
    required this.tableConfigNotifier,
    required this.dataStateNotifier,
    required this.columnStateNotifier,
    required this.rowStateNotifier,
  });

  List<ZooperRowView> buildRowViewList() {
    var rows = <ZooperRowView>[];

    // This should be be sorted rows
    for (int i = 0; i < rowStateNotifier.currentState.length; i++) {
      final row = _buildRowView(rowStateNotifier.currentState[i], i);
      rows.add(row);
    }

    return rows;
  }

  ZooperRowView _buildRowView(ZooperRowModel rowModel, int index) {
    return ZooperRowView(
      tableConfiguration: tableConfigNotifier.currentState,
      columns: columnStateNotifier.currentState,
      row: rowModel,
      rowIndex: index,
    );
  }
}
