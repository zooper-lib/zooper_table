import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';

class TableConfigurationNotifier extends ChangeNotifier {
  TableConfiguration _state;

  TableConfigurationNotifier(this._state);

  TableConfiguration get currentState => _state;

  void updateTableConfiguration(TableConfiguration newConfiguration) {
    _state = newConfiguration;

    notifyListeners();
  }
}
