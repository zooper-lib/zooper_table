import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';

class RowState extends ChangeNotifier {
  List<RowData> _state;

  RowState(this._state);

  List<RowData> get currentState => _state;

  void updateRow(RowData row) {
    var index = _state.indexWhere((element) => element.rowIdentifier == row.rowIdentifier);
    _state[index] = row;
    notifyListeners();
  }

  void updateRowList(List<RowData> rows) {
    _state = rows;
    notifyListeners();
  }

  RowData getRowByIdentifier(String identifier) {
    return _state.firstWhere((element) => element.rowIdentifier == identifier);
  }

  void setNeedsUpdate() {
    notifyListeners();
  }
}
