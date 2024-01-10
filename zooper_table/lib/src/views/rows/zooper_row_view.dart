import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperRowView<T> extends StatelessWidget {
  /// The columns of the table
  final List<ZooperColumnModel> columns;

  /// The data for this row
  final T data;

  /// The index of this row inside the Table
  final int index;

  const ZooperRowView({
    super.key,
    required this.columns,
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cells = _buildCells();

    return Row(
      children: cells,
    );
  }

  List<Widget> _buildCells() {
    var cells = <Widget>[];

    for (final column in columns) {
      final cellView = _buildCell(column);
      cells.add(cellView);
    }

    return cells;
  }

  Widget _buildCell(ZooperColumnModel columnModel) {
    return Consumer(builder: (context, ref, child) {
      final height = ref.watch(tableConfigurationProvider).rowConfiguration.heightBuilder(index);
      final cellValue =
          ref.watch(tableConfigurationProvider).cellConfiguration.cellValueBuilder(data, columnModel.identifier);

      return ZooperCellView(
        rowData: data,
        cellValue: cellValue,
        identifier: columnModel.identifier,
        height: height,
      );
    });
  }
}
