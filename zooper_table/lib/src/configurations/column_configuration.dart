import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ColumnConfiguration {
  /// Callback to get whether the column can be resized.
  ///
  /// This function is called with one argument:
  /// - [identifier]: A string that identifies the column.
  ///
  /// If this function is not provided, a default function is used.
  final bool Function(String identifier) canResizeBuilder;

  /// Callback to get the initial width of the column.
  ///
  /// This function is called with one argument:
  /// - [identifier]: A string that identifies the column.
  ///
  /// If this function is not provided, a default function is used.
  final double Function(String identifier) initialWidthBuilder;

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

  final double? Function() heightBuilder;

  final TextStyle? Function(String identifier) textStyleBuilder;

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

  /// The border builder for the whole header
  final Border? Function() headerBorderBuilder;

  /// A function that returns the border.
  ///
  /// This function is called with two arguments:
  /// - [identifier]: A string that identifies the column.
  /// - [index]: The index of the column.
  ///
  /// If this function is not provided, a default function is used.
  final Border? Function(String identifier, int index) borderBuilder;

  /// A function that returns the icon for ascending sort.
  ///
  /// This function is called with one argument:
  /// - [identifier]: A string that identifies the column.
  ///
  /// If this function is not provided, a default function is used.
  final Widget Function(String identifier) sortAscendingIconBuilder;

  /// A function that returns the icon for descending sort.
  ///
  /// This function is called with one argument:
  /// - [identifier]: A string that identifies the column.
  ///
  /// If this function is not provided, a default function is used.
  final Widget Function(String identifier) sortDescendingIconBuilder;

  ColumnConfiguration({
    bool Function(String identifier)? canResizeBuilder,
    double Function(String identifier)? initialWidthBuilder,
    double Function(String identifier)? minWidthBuilder,
    double Function(String identifier)? maxWidthBuilder,
    double? Function()? heightBuilder,
    TextStyle? Function(String identifier)? textStyleBuilder,
    bool Function(String identifier)? canSortBuilder,
    EdgeInsets Function(String identifier)? paddingBuilder,
    Border? Function()? headerBorderBuilder,
    Border? Function(String identifier, int index)? borderBuilder,
  })  : canResizeBuilder = canResizeBuilder ?? _defaultCanResizeBuilder,
        initialWidthBuilder = initialWidthBuilder ?? _defaultInitialWidthBuilder,
        minWidthBuilder = minWidthBuilder ?? _defaultMinWidthBuilder,
        maxWidthBuilder = maxWidthBuilder ?? _defaultMaxWidthBuilder,
        heightBuilder = heightBuilder ?? _defaultHeightBuilder,
        textStyleBuilder = textStyleBuilder ?? _defaultTextStyleBuilder,
        canSortBuilder = canSortBuilder ?? _defaultCanSortBuilder,
        paddingBuilder = paddingBuilder ?? _defaultPaddingBuilder,
        headerBorderBuilder = headerBorderBuilder ?? _defaultHeaderBorderBuilder,
        borderBuilder = borderBuilder ?? _defaultBorderBuilder,
        sortAscendingIconBuilder = _defaultSortAscendingIconBuilder,
        sortDescendingIconBuilder = _defaultSortDescendingIconBuilder;

  // Default canResize builder
  static bool _defaultCanResizeBuilder(String identifier) {
    return true;
  }

  static double _defaultInitialWidthBuilder(String identifier) {
    return 100.0;
  }

  // Default minWidth builder
  static double _defaultMinWidthBuilder(String identifier) {
    return 50.0;
  }

  // Default maxWidth builder
  static double _defaultMaxWidthBuilder(String identifier) {
    return 500.0;
  }

  static double? _defaultHeightBuilder() {
    return 40;
  }

  static TextStyle? _defaultTextStyleBuilder(String identifier) {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  // Default maxWidth builder
  static bool _defaultCanSortBuilder(String identifier) {
    return true;
  }

  static EdgeInsets _defaultPaddingBuilder(String identifier) {
    return const EdgeInsets.only(right: 10);
  }

  static Border? _defaultHeaderBorderBuilder() {
    return Border(
      bottom: BorderSide(
        color: Colors.grey.shade300,
        width: 1,
      ),
    );
  }

  static Border? _defaultBorderBuilder(String identifier, int index) {
    return null;
  }

  static Widget _defaultSortAscendingIconBuilder(String identifier) {
    return const Icon(LucideIcons.arrowDownAZ, size: 16);
  }

  static Widget _defaultSortDescendingIconBuilder(String identifier) {
    return const Icon(LucideIcons.arrowUpAZ, size: 16);
  }
}
