import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperTable extends StatefulWidget {
  /// The initial state of the table. This is used to restore the state of the table.
  final TableData? initialTableData;

  /// Configuration for this table.
  final TableConfiguration tableConfiguration;

  /// The columns for this table.
  final List<ZooperColumnModel> columns;

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
    List<ZooperRowModel> rows = [];

    for (int i = 0; i < widget.data.length; i++) {
      rows.add(ZooperRowModel(
          identifier: widget.tableConfiguration.rowConfiguration.identifierBuilder.call(
            i,
            widget.data[i],
          ),
          order: i,
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
        ChangeNotifierProvider<RowStateNotifier>(
          create: (_) => RowStateNotifier(rows),
        ),
        ChangeNotifierProvider<DataStateNotifier>(
          create: (_) => DataStateNotifier(widget.data),
        ),

        // The state of the table which gets initialized with the initial table data.
        ChangeNotifierProvider<TableState>(
          create: (_) => TableState(
            TableService.initializeTable(
              widget.initialTableData,
              widget.tableConfiguration.initialColumnOrder,
              widget.columns,
              null,
              null,
            ),
          ),
        ),
        Provider<ColumnService>(
          create: (context) => ColumnService(
            tableConfigNotifier: context.read(),
            columnStateNotifier: context.read(),
            rowStateNotifier: context.read(),
          ),
        ),
        Provider<RowService>(
          create: (context) => RowService(
            tableConfigNotifier: context.read(),
            dataStateNotifier: context.read(),
            columnStateNotifier: context.read(),
            rowStateNotifier: context.read(),
          ),
        ),
        Provider<TableService>(
          create: (context) => TableService(),
        ),
      ],
      child: Consumer6<TableState, ColumnService, RowService, DataStateNotifier, ColumnStateNotifier, RowStateNotifier>(
        builder: (context, tableState, columnService, rowService, dataStateNotifier, columnStateNotifier,
            rowStateNotifier, child) {
          final columnViewList = columnService.buildColumnViewList();
          final rowViewList = rowService.buildRowViewList();

          return Column(
            children: [
              _buildColumns(columnViewList),
              SizedBox(
                height: 200,
                child: _buildContent(rowViewList),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildColumns(List<ZooperColumnView> columnViews) {
    return Row(
      children: columnViews,
    );
  }

  Widget _buildContent(List<ZooperRowView> rowViews) {
    return Consumer<TableService>(
      builder: (context, tableService, child) => CustomScrollView(
        controller: ScrollController(),
        slivers: <Widget>[
          ReorderableSliverList(
            // TODO: implement isEnabled based on if any column is sorted.
            // TODO: Also implement a property inside the Configuration to disable ordering of rows.

            buildDraggableFeedback: (context, constraints, child) => Container(
              color: Colors.red,
              child: child,
            ),
            delegate: ReorderableSliverChildListDelegate(rowViews),
            onReorder: (oldIndex, newIndex) => {
              //tableService.reorderRow(oldIndex, newIndex),
              print('Reorder from $oldIndex to $newIndex'),
            },
          ),
        ],
      ),
    );
  }
}
