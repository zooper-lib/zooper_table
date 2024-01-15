import 'package:zooper_table/zooper_table.dart';

class ColumnSort {
  final String identifier;
  final SortOrder sortOrder;

  ColumnSort({
    required this.identifier,
    required this.sortOrder,
  });

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'sortOrder': sortOrder.toString(),
    };
  }

  factory ColumnSort.fromJson(Map<String, dynamic> json) {
    return ColumnSort(
      identifier: json['identifier'],
      sortOrder: SortOrder.values.firstWhere((e) => e.toString() == json['sortOrder']),
    );
  }
}
