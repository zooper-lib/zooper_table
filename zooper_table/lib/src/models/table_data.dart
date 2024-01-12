import 'package:zooper_table/zooper_table.dart';

class TableData {
  /// The order of the columns appearance
  List<String> columnOrder;

  /// The identifier of the column which is primarly sorty
  ColumnSort? primaryColumnSort;

  /// The identifier of the column which is secondarly sorted
  ColumnSort? secondaryColumnSort;

  TableData({
    required this.columnOrder,
    this.primaryColumnSort,
    this.secondaryColumnSort,
  });
}