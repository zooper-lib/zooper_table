import 'package:flutter/material.dart';

class CellConfiguration {
  /// A function that returns the cell value as a string.
  ///
  /// This function is called with two arguments:
  /// - [data]: The data associated with the cell.
  /// - [identifier]: A string that identifies the column.
  ///
  /// If this function is not provided, a default function is used.
  final String Function(dynamic data, String identifier) cellValueBuilder;

  /// A function that returns the padding for a cell.
  ///
  /// This function is called with three arguments:
  /// - [data]: The data associated with the cell.
  /// - [identifier]: A string that identifies the column.
  /// - [index]: The index of the cell in its row.
  ///
  /// If this function is not provided, a default function is used.
  final EdgeInsets Function(dynamic data, String identifier, int index) paddingBuilder;

  /// A function that returns the border for a cell.
  ///
  /// This function is called with three arguments:
  /// - [data]: The data associated with the cell.
  /// - [identifier]: A string that identifies the column.
  /// - [index]: The index of the cell in its row.
  ///
  /// If this function is not provided, a default function is used.
  final Border Function(dynamic data, String identifier, int index) borderBuilder;

  CellConfiguration({
    String Function(dynamic data, String identifier)? cellValueBuilder,
    EdgeInsets Function(dynamic data, String identifier, int index)? paddingBuilder,
    Border Function(dynamic data, String identifier, int index)? borderBuilder,
  })  : cellValueBuilder = cellValueBuilder ?? _defaultCellValue,
        paddingBuilder = paddingBuilder ?? _defaultPaddingBuilder,
        borderBuilder = borderBuilder ?? _defaultBorderBuilder;

  static String _defaultCellValue(dynamic data, String identifier) {
    return data.toString();
  }

  static EdgeInsets _defaultPaddingBuilder(dynamic data, String identifier, int index) {
    return const EdgeInsets.all(4);
  }

  static Border _defaultBorderBuilder(dynamic data, String identifier, int index) {
    return Border(
      left: index != 0
          ? BorderSide.none
          : BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
      right: BorderSide(
        color: Colors.grey.shade300,
        width: 1,
      ),
      bottom: BorderSide(
        color: Colors.grey.shade300,
        width: 1,
      ),
    );
  }
}
