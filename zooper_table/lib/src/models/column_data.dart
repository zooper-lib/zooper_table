import 'package:zooper_table/zooper_table.dart';

class ColumnData {
  final String identifier;
  final String title;

  ColumnData({
    required this.identifier,
    required this.title,
  });

  ColumnData copyWith({
    String? title,
    int? order,
    double? width,
    SortOrder? sortOrder,
  }) {
    return ColumnData(
      identifier: identifier,
      title: title ?? this.title,
    );
  }
}
