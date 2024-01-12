import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';

class RowStateNotifier extends ChangeNotifier {
  List<ZooperRowModel> _state;

  RowStateNotifier(this._state);

  List<ZooperRowModel> get currentState => _state;

  void updateRow(ZooperRowModel row) {
    var index = _state.indexWhere((element) => element.identifier == row.identifier);
    _state[index] = row;
    notifyListeners();
  }

  void updateRowList(List<ZooperRowModel> rows) {
    _state = rows;
    notifyListeners();
  }

  ZooperRowModel getRowByIdentifier(String identifier) {
    return _state.firstWhere((element) => element.identifier == identifier);
  }

  ZooperRowModel getRowByOrder(int order) {
    return _state.firstWhere((element) => element.order == order);
  }
}
