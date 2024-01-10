import 'package:flutter/widgets.dart';
import 'package:zooper_table/zooper_table.dart';

class TableConfigurationNotifier<TData> extends ChangeNotifier {
  TableConfiguration<TData> _tableConfiguration;

  TableConfigurationNotifier(this._tableConfiguration);

  TableConfiguration<TData> get tableConfiguration => _tableConfiguration;

  void updateTableConfiguration(TableConfiguration<TData> tableConfiguration) {
    _tableConfiguration = tableConfiguration;
    notifyListeners();
  }
}
