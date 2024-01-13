import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperTable extends StatefulWidget {
  /// The initial state of the table. This is used to restore the state of the table.
  final TableData? initialTableData;

  /// Configuration for this table.
  final TableConfiguration tableConfiguration;

  /// The columns for this table.
  final List<ColumnData> columns;

  /// The data for this table.
  final List<dynamic> data;

  const ZooperTable({
    super.key,
    this.initialTableData,
    required this.tableConfiguration,
    required this.columns,
    required this.data,
  });

  @override
  State<ZooperTable> createState() => _ZooperTableState();
}

class _ZooperTableState extends State<ZooperTable> {
  @override
  Widget build(BuildContext context) {
    List<RowData> rows = [];

    for (int i = 0; i < widget.data.length; i++) {
      rows.add(RowData(
          identifier: widget.tableConfiguration.rowConfiguration.identifierBuilder.call(
            i,
            widget.data[i],
          ),
          data: widget.data[i]));
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TableConfigurationNotifier>(
          create: (_) => TableConfigurationNotifier(widget.tableConfiguration),
        ),
        ChangeNotifierProvider<ColumnStateNotifier>(
          create: (_) => ColumnStateNotifier(widget.columns),
        ),
        ChangeNotifierProvider<RowState>(
          create: (_) => RowState(rows),
        ),
        ChangeNotifierProvider<DataStateNotifier>(
          create: (_) => DataStateNotifier(widget.data),
        ),

        // The state of the table which gets initialized with the initial table data.
        ChangeNotifierProvider<TableState>(
          create: (_) => TableState(
            TableService.initializeTable(
              widget.tableConfiguration,
              widget.initialTableData,
              widget.tableConfiguration.initialColumnOrder,
              widget.columns,
              null,
              null,
            ),
          ),
        ),
        Provider<TableService>(
          create: (context) => TableService(),
        ),
        Provider<RowService>(
          create: (context) => RowService(
            tableConfigNotifier: context.read(),
            dataStateNotifier: context.read(),
            columnStateNotifier: context.read(),
            rowState: context.read(),
            tableState: context.read(),
          ),
        ),
        Provider<ColumnService>(
          create: (context) => ColumnService(
            rowService: context.read(),
            tableConfigNotifier: context.read(),
            tableState: context.read(),
            columnStateNotifier: context.read(),
          ),
        ),
        Provider<CellService>(
          create: (context) => CellService(
            tableConfigurationNotifier: context.read(),
            dataStateNotifier: context.read(),
          ),
        ),
      ],
      child: const Column(
        children: [
          ZooperColumnsHeaderView(),
          Expanded(
            child: ZooperRowListView(),
          ),
        ],
      ),
    );
  }
}
