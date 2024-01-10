import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zooper_table/zooper_table.dart';

class ColumnStateNotifier extends StateNotifier<List<ZooperColumnModel>> {
  ColumnStateNotifier(List<ZooperColumnModel> columns) : super(columns);

  List<ZooperColumnModel> get currentState => state;

  void updateColumn(ZooperColumnModel column) {
    var index = state.indexWhere((element) => element.identifier == column.identifier);
    state[index] = column;
    state = List.from(state);
  }

  ZooperColumnModel getColumn(String identifier) {
    return state.firstWhere((element) => element.identifier == identifier);
  }
}
