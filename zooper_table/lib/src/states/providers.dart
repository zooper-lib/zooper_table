import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zooper_table/zooper_table.dart';

final columnStateProvider = StateNotifierProvider<ColumnStateNotifier, List<ZooperColumnModel>>((ref) {
  return ColumnStateNotifier([]);
});

final tableConfigurationProvider = StateNotifierProvider<TableConfigurationNotifier, TableConfiguration>((ref) {
  return TableConfigurationNotifier(TableConfiguration());
});

final dataStateProvider = StateNotifierProvider<DataStateNotifier, dynamic>((ref) {
  return DataStateNotifier([]);
});

final columnServiceProvider = Provider<ColumnService>((ref) {
  return ColumnService(
    tableConfigNotifier: ref.watch(tableConfigurationProvider.notifier),
    columnStateNotifier: ref.watch(columnStateProvider.notifier),
  );
});

final rowServiceProvider = Provider<RowService>((ref) {
  return RowService(
    tableConfigNotifier: ref.watch(tableConfigurationProvider.notifier),
    dataStateNotifier: ref.watch(dataStateProvider.notifier),
    columnStateNotifier: ref.watch(columnStateProvider.notifier),
  );
});
