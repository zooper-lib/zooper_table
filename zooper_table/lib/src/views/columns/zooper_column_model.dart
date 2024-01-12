import 'package:zooper_table/zooper_table.dart';

class ZooperColumnModel {
  final String identifier;
  final String title;

  ZooperColumnModel({
    required this.identifier,
    required this.title,
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
    );
  }
}
