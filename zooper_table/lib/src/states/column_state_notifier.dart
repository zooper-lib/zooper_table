import 'package:flutter/widgets.dart';
import 'package:zooper_table/zooper_table.dart';

class ColumnStateNotifier<TData> extends ChangeNotifier {
  final TableConfiguration<TData> tableConfiguration;

  final List<ZooperColumnModel> columns;

  ColumnStateNotifier(
    this.tableConfiguration,
    this.columns,
  );

  void updateColumnWidthByIdentifier(String identifier, double delta) {
    var index = columns.indexWhere((element) => element.identifier == identifier);

    return updateColumnWidthByIndex(index, delta);
  }

  void updateColumnWidthByIndex(int index, double delta) {
    var column = columns[index];

    updateColumnWidth(column, delta);
  }

  void updateColumnWidth(ZooperColumnModel column, double delta) {
    // set the columns width to the new width
    column.width += delta;

    final minWidth = tableConfiguration.columnHeaderConfiguration.minWidthBuilder(column.identifier);
    final maxWidth = tableConfiguration.columnHeaderConfiguration.maxWidthBuilder(column.identifier);

    if (column.width < minWidth) {
      column.width = minWidth;
    } else if (column.width > maxWidth) {
      column.width = maxWidth;
    }

    // update the state
    notifyListeners();
  }

  ZooperColumnModel getColumn(String identifier) {
    return columns.firstWhere((element) => element.identifier == identifier);
  }
}
