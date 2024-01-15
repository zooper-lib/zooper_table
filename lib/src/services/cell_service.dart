import 'package:zooper_table/zooper_table.dart';

class CellService {
  final TableConfigurationNotifier tableConfigurationNotifier;
  final DataStateNotifier dataStateNotifier;

  CellService({
    required this.tableConfigurationNotifier,
    required this.dataStateNotifier,
  });
}
