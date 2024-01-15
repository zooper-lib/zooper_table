import 'package:zooper_table/zooper_table.dart';

class TableData {
  /// The order of the columns appearance
  List<String> columnOrder;

  /// The identifier of the column which is primarly sorty
  ColumnSort? primaryColumnSort;

  /// The identifier of the column which is secondarly sorted
  ColumnSort? secondaryColumnSort;

  /// The width of the columns
  Map<String, double> columnWidths;

  TableData({
    required this.columnOrder,
    required this.primaryColumnSort,
    required this.secondaryColumnSort,
    required this.columnWidths,
  });

  Map<String, dynamic> toJson() {
    return {
      'columnOrder': columnOrder,
      'primaryColumnSort': primaryColumnSort?.toJson(),
      'secondaryColumnSort': secondaryColumnSort?.toJson(),
      'columnWidths': columnWidths,
    };
  }

  factory TableData.fromJson(Map<String, dynamic> json) {
    return TableData(
      columnOrder: List<String>.from(json['columnOrder']),
      primaryColumnSort: json['primaryColumnSort'] != null ? ColumnSort.fromJson(json['primaryColumnSort']) : null,
      secondaryColumnSort:
          json['secondaryColumnSort'] != null ? ColumnSort.fromJson(json['secondaryColumnSort']) : null,
      columnWidths: Map<String, double>.from(json['columnWidths']),
    );
  }
}
