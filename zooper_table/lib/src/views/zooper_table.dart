import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return ProviderScope(
      overrides: [
        tableConfigurationProvider.overrideWith((ref) => TableConfigurationNotifier(widget.tableConfiguration)),
        columnStateProvider.overrideWith((ref) => ColumnStateNotifier(widget.columns)),
        dataStateProvider.overrideWith((ref) => DataStateNotifier(widget.data)),
      ],
      child: Consumer(builder: (context, ref, child) {
        final columnService = ref.watch(columnServiceProvider);
        final rowService = ref.watch(rowServiceProvider);
        final dataStateNotifier = ref.watch(dataStateProvider.notifier);

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
