import 'package:zooper_table/zooper_table.dart';

class RowService {
  final TableConfigurationNotifier tableConfigNotifier;
  final DataStateNotifier dataStateNotifier;
  final ColumnStateNotifier columnStateNotifier;

  RowService({
    required this.tableConfigNotifier,
    required this.dataStateNotifier,
    required this.columnStateNotifier,
  });

  List<ZooperRowView> buildRowViewList() {
    var rows = <ZooperRowView>[];

    for (int i = 0; i < dataStateNotifier.currentState.length; i++) {
      final row = _buildRowView(dataStateNotifier.currentState[i], i);
      rows.add(row);
    }

    return rows;
  }

  ZooperRowView _buildRowView(dynamic data, int index) {
    return ZooperRowView(
      columns: columnStateNotifier.currentState,
      data: data,
      index: index,
    );
  }
}
