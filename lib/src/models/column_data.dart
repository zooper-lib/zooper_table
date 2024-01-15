import 'package:zooper_table/zooper_table.dart';

class ColumnData {
  /// The identifier of the column
  final String identifier;

  /// The title of the column
  final String title;

  /// The side where the column will stick at
  final ColumnStick columnStick;

  ColumnData({
    required this.identifier,
    required this.title,
    this.columnStick = ColumnStick.center,
  });
}
