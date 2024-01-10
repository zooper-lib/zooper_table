import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperTable<T> extends StatefulWidget {
  /// Configuration for this table.
  final TableConfiguration<T> tableConfiguration;

  /// The columns for this table.
  final List<ZooperColumnModel> columns;

  /// The data for this table.
  final List<T> data;

  const ZooperTable({
    super.key,
    required this.tableConfiguration,
    required this.columns,
    required this.data,
  });

  @override
  State<ZooperTable<T>> createState() => _ZooperTableState();
}

class _ZooperTableState<TData> extends State<ZooperTable<TData>> {
  late final TableConfigurationNotifier<TData> tableConfigurationNotifier;
  late final ColumnStateNotifier columnStateNotifier;
  late final DataStateNotifier dataStateNotifier;

  @override
  void initState() {
    super.initState();

    tableConfigurationNotifier = TableConfigurationNotifier<TData>(
      widget.tableConfiguration,
    );

    columnStateNotifier = ColumnStateNotifier(
      widget.tableConfiguration,
      widget.columns,
    );

    dataStateNotifier = DataStateNotifier<TData>(
      widget.tableConfiguration,
      widget.data,
    );
  }

  @override
  Widget build(BuildContext context) {
    final header = _buildColumns();
    final content = _buildContent();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: tableConfigurationNotifier),
        ChangeNotifierProvider.value(value: columnStateNotifier),
        ChangeNotifierProvider.value(value: dataStateNotifier),
        ProxyProvider2<TableConfigurationNotifier<TData>, ColumnStateNotifier, ColumnHelper>(
          update: (_, tableConfigurationNotifier, columnStateNotifier, __) {
            return ColumnHelper(
              tableConfigurationNotifier,
              columnStateNotifier,
            );
          },
        ),
        ProxyProvider3<ColumnStateNotifier, DataStateNotifier, TableConfigurationNotifier<TData>, RowHelper<TData>>(
          update: (_, columnStateNotifier, dataStateNotifier, tableConfigurationNotifier, __) {
            return RowHelper<TData>(
              columnStateNotifier,
              dataStateNotifier,
              tableConfigurationNotifier,
            );
          },
        ),
      ],
      child: Column(
        children: [
          header,
          content,
        ],
      ),
    );
  }

  Widget _buildColumns() {
    return Consumer2<ColumnStateNotifier, ColumnHelper>(
      builder: (context, columnStateNotifier, columnHelper, child) {
        return Row(
          children: columnHelper.buildColumns(),
        );
      },
    );
  }

  Widget _buildContent() {
    return Consumer<RowHelper<TData>>(
      builder: (context, rowHelper, child) {
        return Column(
          children: rowHelper.buildRows(),
        );
      },
    );
  }
}
