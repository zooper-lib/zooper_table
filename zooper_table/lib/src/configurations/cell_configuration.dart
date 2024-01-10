import 'package:flutter/widgets.dart';

class CellConfiguration {
  final String Function(dynamic data, String identifier) cellValue;
  final EdgeInsets Function(dynamic data, String identifier, int index) paddingBuilder;

  CellConfiguration({
    String Function(dynamic data, String identifier)? cellValue,
    EdgeInsets Function(dynamic data, String identifier, int index)? paddingBuilder,
  })  : cellValue = cellValue ?? _defaultCellValue,
        paddingBuilder = paddingBuilder ?? _defaultPaddingBuilder;

  static String _defaultCellValue(dynamic data, String identifier) {
    return data.toString();
  }

  static EdgeInsets _defaultPaddingBuilder(dynamic data, String identifier, int index) {
    return const EdgeInsets.all(4);
  }
}
