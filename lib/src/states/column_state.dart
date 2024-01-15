import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';

class ColumnState extends ChangeNotifier {
  List<ColumnData> _dataColumns;

  ColumnState(this._dataColumns);

  List<ColumnData> get dataColumns => _dataColumns;

  void updateDataColumn(ColumnData column) {
    var index = _dataColumns.indexWhere((element) => element.identifier == column.identifier);
    _dataColumns[index] = column;
    notifyListeners();
  }

  void updateAllDataColumns(List<ColumnData> columns) {
    _dataColumns = columns;
    notifyListeners();
  }

  ColumnData getDataColumn(String identifier) {
    return _dataColumns.firstWhere((element) => element.identifier == identifier);
  }
}
