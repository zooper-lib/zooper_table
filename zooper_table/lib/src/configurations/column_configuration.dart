import 'package:flutter/material.dart';

class ColumnConfiguration {
  /// Callback to get the minimum width of the column.
  ///
  /// This function is called with one argument:
  /// - [identifier]: A string that identifies the column.
  ///
  /// If this function is not provided, a default function is used.
  final double Function(String identifier) minWidthBuilder;

  /// Callback to get the maximum width of the column.
  ///
  /// This function is called with one argument:
  /// - [identifier]: A string that identifies the column.
  ///
  /// If this function is not provided, a default function is used.
  final double Function(String identifier) maxWidthBuilder;

  /// Callback to get whether the column can be sorted.
  ///
  /// This function is called with one argument:
  /// - [identifier]: A string that identifies the column.
  ///
  /// If this function is not provided, a default function is used.
  final bool Function(String identifier) canSortBuilder;

  /// Callback to get the padding for a cell.
  ///
  /// This function is called with one argument:
  /// - [identifier]: A string that identifies the column.
  ///
  /// If this function is not provided, a default function is used.
  final EdgeInsets Function(String identifier) paddingBuilder;

  /// A function that returns the border.
  ///
  /// This function is called with two arguments:
  /// - [identifier]: A string that identifies the column.
  /// - [index]: The index of the column.
  ///
  /// If this function is not provided, a default function is used.
  final Border Function(String identifier, int index) borderBuilder;

  ColumnConfiguration({
    double Function(String identifier)? minWidthBuilder,
    double Function(String identifier)? maxWidthBuilder,
    bool Function(String identifier)? canSort,
    EdgeInsets Function(String identifier)? paddingBuilder,
    Border Function(String identifier, int index)? borderBuilder,
  })  : minWidthBuilder = minWidthBuilder ?? _defaultMinWidthBuilder,
        maxWidthBuilder = maxWidthBuilder ?? _defaultMaxWidthBuilder,
        canSortBuilder = canSort ?? _defaultCanSortBuilder,
        paddingBuilder = paddingBuilder ?? _defaultPaddingBuilder,
        borderBuilder = borderBuilder ?? _defaultBorderBuilder;

  // Default minWidth builder
  static double _defaultMinWidthBuilder(String identifier) {
    return 50.0;
  }

  // Default maxWidth builder
  static double _defaultMaxWidthBuilder(String identifier) {
    return 200.0;
  }

  // Default maxWidth builder
  static bool _defaultCanSortBuilder(String identifier) {
    return true;
  }

  static EdgeInsets _defaultPaddingBuilder(String identifier) {
    return const EdgeInsets.all(4);
  }

  static Border _defaultBorderBuilder(String identifier, int index) {
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
