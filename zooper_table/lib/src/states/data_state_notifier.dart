import 'package:flutter/widgets.dart';
import 'package:zooper_table/zooper_table.dart';

class DataStateNotifier<TData> extends ChangeNotifier {
  final TableConfiguration tableConfiguration;

  final List<TData> data;

  DataStateNotifier(
    this.tableConfiguration,
    this.data,
  );
}
