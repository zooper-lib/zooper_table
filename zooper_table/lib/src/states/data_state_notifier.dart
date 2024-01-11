import 'package:flutter/material.dart';

class DataStateNotifier extends ChangeNotifier {
  List<dynamic> _state;

  DataStateNotifier(this._state);

  List<dynamic> get currentState => _state;

  void updateAllData(List<dynamic> data) {
    _state = data;
    notifyListeners();
  }
}
