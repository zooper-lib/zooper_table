import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';

class ColumnStateNotifier extends ChangeNotifier {
  List<ZooperColumnModel> _state;

  ColumnStateNotifier(this._state);

  List<ZooperColumnModel> get currentState => _state;

  void updateColumn(ZooperColumnModel column) {
    var index = _state.indexWhere((element) => element.identifier == column.identifier);
    _state[index] = column;
    notifyListeners();
  }

  void updateAllColumns(List<ZooperColumnModel> columns) {
    _state = columns;
    notifyListeners();
  }

  ZooperColumnModel getColumn(String identifier) {
    return _state.firstWhere((element) => element.identifier == identifier);
  }
}
