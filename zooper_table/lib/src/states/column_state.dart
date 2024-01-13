import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';

class ColumnState extends ChangeNotifier {
  List<ColumnData> _state;

  ColumnState(this._state);

  List<ColumnData> get currentState => _state;

  void updateColumn(ColumnData column) {
    var index = _state.indexWhere((element) => element.identifier == column.identifier);
    _state[index] = column;
    notifyListeners();
  }

  void updateAllColumns(List<ColumnData> columns) {
    _state = columns;
    notifyListeners();
  }

  ColumnData getColumn(String identifier) {
    return _state.firstWhere((element) => element.identifier == identifier);
  }
}
