import 'package:zooper_table/zooper_table.dart';

class ZooperColumnModel {
  final String identifier;
  final String title;
  int order;
  double width;
  SortOrder sortOrder;

  ZooperColumnModel({
    required this.identifier,
    required this.title,
    required this.order,
    this.width = 100,
    this.sortOrder = SortOrder.none,
  });

  ZooperColumnModel copyWith({
    String? title,
    int? order,
    double? width,
    SortOrder? sortOrder,
  }) {
    return ZooperColumnModel(
      identifier: identifier,
      title: title ?? this.title,
      order: order ?? this.order,
      width: width ?? this.width,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
