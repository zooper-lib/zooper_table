import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';

class RowState extends ChangeNotifier {
  List<RowData> _state;

  RowState(this._state);

  List<RowData> get currentState => _state;

  void updateRow(RowData row) {
    var index = _state.indexWhere((element) => element.identifier == row.identifier);
    _state[index] = row;
    notifyListeners();
  }

  void updateRowList(List<RowData> rows) {
    _state = rows;
    notifyListeners();
  }

  RowData getRowByIdentifier(String identifier) {
    return _state.firstWhere((element) => element.identifier == identifier);
  }

  void setNeedsUpdate() {
    notifyListeners();
  }
}
