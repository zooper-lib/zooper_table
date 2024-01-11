import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperTable extends StatefulWidget {
  /// Configuration for this table.
  final TableConfiguration tableConfiguration;

  /// The columns for this table.
  final List<ZooperColumnModel> columns;

  /// The data for this table.
  final List<dynamic> data;

  const ZooperTable({
    super.key,
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TableConfigurationNotifier>(
          create: (_) => TableConfigurationNotifier(widget.tableConfiguration),
        ),
        ChangeNotifierProvider<ColumnStateNotifier>(
          create: (_) => ColumnStateNotifier(widget.columns),
        ),
        ChangeNotifierProvider<DataStateNotifier>(
          create: (_) => DataStateNotifier(widget.data),
        ),
        Provider<ColumnService>(
          create: (context) => ColumnService(
            tableConfigNotifier: context.read(),
            columnStateNotifier: context.read(),
            dataStateNotifier: context.read(),
          ),
        ),
        Provider<RowService>(
          create: (context) => RowService(
            tableConfigNotifier: context.read(),
            dataStateNotifier: context.read(),
            columnStateNotifier: context.read(),
          ),
        )
      ],
      child: Consumer3<ColumnService, RowService, DataStateNotifier>(
          builder: (context, columnService, rowService, dataStateNotifier, child) {
        final columnViewList = columnService.buildColumnViewList();
        final rowViewList = rowService.buildRowViewList();

        return Column(
          children: [
            _buildColumns(columnViewList),
            _buildContent(rowViewList),
          ],
        );
      }),
    );
  }

  Widget _buildColumns(List<ZooperColumnView> columnViews) {
    return Row(
      children: columnViews,
    );
  }

  Widget _buildContent(List<ZooperRowView> rowViews) {
    return Column(
      children: rowViews,
    );
  }
}
