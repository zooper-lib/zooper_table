import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ColumnConfiguration {
  /// Determines if a column identified by [identifier] can be resized.
  final bool Function(String identifier) canResizeBuilder;

  /// Provides the initial width for a column identified by [identifier].
  final double Function(String identifier) initialWidthBuilder;

  /// Determines the minimum width for a column identified by [identifier].
  final double Function(String identifier) minWidthBuilder;

  /// Determines the maximum width for a column identified by [identifier].
  final double Function(String identifier) maxWidthBuilder;

  /// Provides a builder for the height of rows.
  final double? Function() heightBuilder;

  /// Provides the text style for a column identified by [identifier].
  final TextStyle? Function(String identifier) textStyleBuilder;

  /// Determines if a column identified by [identifier] can be sorted.
  final bool Function(String identifier) canSortBuilder;

  /// Provides the padding for a column identified by [identifier].
  final EdgeInsets Function(String identifier) paddingBuilder;

  /// Provides a builder for the border of the header.
  final Border? Function() headerBorderBuilder;

  /// Provides a builder for the border of a row, given the column [identifier] and row [index].
  final Border? Function(String identifier, int index) borderBuilder;

  /// Provides a widget for the ascending sort icon for a primary column identified by [identifier].
  final Widget Function(String identifier) primarySortAscendingIconBuilder;

  /// Provides a widget for the descending sort icon for a primary column identified by [identifier].
  final Widget Function(String identifier) primarySortDescendingIconBuilder;

  /// Provides a widget for the ascending sort icon for a secondary column identified by [identifier].
  final Widget Function(String identifier) secondarySortAscendingIconBuilder;

  /// Provides a widget for the descending sort icon for a secondary column identified by [identifier].
  final Widget Function(String identifier) secondarySortDescendingIconBuilder;

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
        primarySortAscendingIconBuilder = _defaultPrimarySortAscendingIconBuilder,
        primarySortDescendingIconBuilder = _defaultPrimarySortDescendingIconBuilder,
        secondarySortAscendingIconBuilder = _defaultSecondarySortAscendingIconBuilder,
        secondarySortDescendingIconBuilder = _defaultSecondarySortDescendingIconBuilder;

  static bool _defaultCanResizeBuilder(String identifier) {
    return true;
  }

  static double _defaultInitialWidthBuilder(String identifier) {
    return 100.0;
  }

  static double _defaultMinWidthBuilder(String identifier) {
    return 50.0;
  }

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

  static Widget _defaultPrimarySortAscendingIconBuilder(String identifier) {
    return const Icon(LucideIcons.arrowDown, size: 16);
  }

  static Widget _defaultPrimarySortDescendingIconBuilder(String identifier) {
    return const Icon(LucideIcons.arrowUp, size: 16);
  }

  static Widget _defaultSecondarySortAscendingIconBuilder(String identifier) {
    return const Icon(LucideIcons.arrowDown, size: 12);
  }

  static Widget _defaultSecondarySortDescendingIconBuilder(String identifier) {
    return const Icon(LucideIcons.arrowUp, size: 12);
  }
}
