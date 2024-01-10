import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zooper_table/zooper_table.dart';

class TableConfigurationNotifier extends StateNotifier<TableConfiguration> {
  TableConfigurationNotifier(TableConfiguration state) : super(state);

  TableConfiguration get currentState => state;

  void updateTableConfiguration(TableConfiguration newConfiguration) {
    state = newConfiguration;
  }

  void overrideWithValue(TableConfiguration newConfiguration) {
    state = newConfiguration;
  }
}
