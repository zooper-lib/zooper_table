import 'package:flutter/material.dart';

class CellConfiguration {
  /// Defines a function to dynamically determine padding for a widget based on various parameters.
  ///
  /// This function is used to compute custom padding for a specific element in a grid or list layout.
  /// It takes four parameters:
  /// - [identifier]: A unique string identifier for the element, typically used to distinguish different types of elements.
  /// - [columnIndex]: The index of the column in which the element is located. Useful for layouts with multiple columns.
  /// - [rowIndex]: The index of the row in which the element is located. Essential for multi-row layouts or when dealing with lists.
  /// - [data]: Any additional dynamic data that might influence the padding. This could be the actual content of the element or other contextual information.
  ///
  /// Returns an [EdgeInsets] object that represents the padding to be applied to the element identified by [identifier], at the specified [columnIndex] and [rowIndex], considering the provided [data].
  ///
  /// This function is particularly useful for creating dynamic and responsive layouts where padding needs to vary based on content and position.
  final EdgeInsets Function(String identifier, int columnIndex, int rowIndex, dynamic data) paddingBuilder;

  /// A function that returns the border for a cell.
  ///
  /// This function is called with three arguments:
  /// - [data]: The data associated with the cell.
  /// - [identifier]: A string that identifies the column.
  /// - [index]: The index of the cell in its row.
  ///
  /// If this function is not provided, a default function is used.
  final Border? Function(dynamic data, String identifier, int columnIndex, int rowIndex) borderBuilder;

  CellConfiguration({
    EdgeInsets Function(String identifier, int columnIndex, int rowIndex, dynamic data)? paddingBuilder,
    Border? Function(dynamic data, String identifier, int columnIndex, int rowIndex)? borderBuilder,
  })  : paddingBuilder = paddingBuilder ?? _defaultPaddingBuilder,
        borderBuilder = borderBuilder ?? _defaultBorderBuilder;

  static EdgeInsets _defaultPaddingBuilder(String identifier, int columnIndex, int rowIndex, dynamic data) {
    return const EdgeInsets.only(right: 10);
  }

  static Border? _defaultBorderBuilder(dynamic data, String columnIdentifier, int columnIndex, int rowIndex) {
    return null;
  }
}
