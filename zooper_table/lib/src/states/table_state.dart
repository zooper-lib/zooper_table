import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';

class TableState with ChangeNotifier {
  TableData _tableData;

  TableState(this._tableData);

  TableData get currentState => _tableData;

  void updateState(TableData tableData) {
    _tableData = tableData;
    notifyListeners();
  }
}
