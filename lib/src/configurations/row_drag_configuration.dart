import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RowDragConfiguration {
  /// A builder that determines whether reordering is enabled.
  ///
  /// Returns `true` if reordering is enabled, otherwise `false`.
  final bool Function() isReorderingEnabledBuilder;

  /// A builder that determines whether the drag handle is enabled for a specific row.
  ///
  /// Takes a single parameter [rowIndex], which is the index of the row.
  /// Returns `true` if the drag handle is enabled for the row at [rowIndex], otherwise `false`.
  final bool Function(int rowIndex) isRowDragHandleEnabledBuilder;

  /// A builder that creates a drag handle widget for a specific row.
  ///
  /// Takes a single parameter [rowIndex], which is the index of the row.
  /// Returns a [Widget] that represents the drag handle for the row at [rowIndex].
  final Widget Function(int rowIndex) rowDragHandleBuilder;

  /// A builder that provides the width for a specific row based on its data.
  ///
  /// Takes two parameters:
  /// - [rowIndex]: An integer representing the index of the row.
  /// - [data]: Dynamic data associated with the row.
  /// Returns a nullable `double` representing the width for the row at [rowIndex].
  final double? Function(int rowIndex, dynamic data) widthBuilder;

  /// A builder that provides the padding for a specific row based on its data.
  ///
  /// Takes two parameters:
  /// - [rowIndex]: An integer representing the index of the row.
  /// - [data]: Dynamic data associated with the row.
  /// Returns a nullable `double` representing the padding for the row at [rowIndex].
  final EdgeInsets? Function(int rowIndex, dynamic data) paddingBuilder;

  /// A builder that defines the border for a specific row based on its data.
  ///
  /// Takes two parameters:
  /// - [rowIndex]: An integer representing the index of the row.
  /// - [data]: Dynamic data associated with the row.
  /// Returns a [Border] representing the border for the row at [rowIndex].
  final Border? Function(int rowIndex, dynamic data) borderBuilder;

  RowDragConfiguration({
    bool Function()? isReorderingEnabledBuilder,
    bool Function(int rowIndex)? isRowDragHandleEnabledBuilder,
    Widget Function(int rowIndex)? rowDragHandleBuilder,
    double? Function(int rowIndex, dynamic data)? widthBuilder,
    EdgeInsets? Function(int rowIndex, dynamic data)? paddingBuilder,
    Border? Function(int rowIndex, dynamic data)? borderBuilder,
  })  : isReorderingEnabledBuilder = isReorderingEnabledBuilder ?? _defaultIsReorderingEnabledBuilder,
        isRowDragHandleEnabledBuilder = isRowDragHandleEnabledBuilder ?? _defaultIsRowDragHandleEnabledBuilder,
        rowDragHandleBuilder = rowDragHandleBuilder ?? _defaultRowDragHandleBuilder,
        widthBuilder = widthBuilder ?? _defaultWidthBuilder,
        paddingBuilder = paddingBuilder ?? _defaultPaddingBuilder,
        borderBuilder = borderBuilder ?? _defaultBorderBuilder;

  static bool _defaultIsReorderingEnabledBuilder() {
    return true;
  }

  static bool _defaultIsRowDragHandleEnabledBuilder(int rowIndex) {
    return true;
  }

  static Widget _defaultRowDragHandleBuilder(int rowIndex) {
    return const Icon(
      LucideIcons.gripVertical,
      size: 16,
    );
  }

  static double? _defaultWidthBuilder(int rowIndex, dynamic data) {
    return 30;
  }

  static EdgeInsets? _defaultPaddingBuilder(int rowIndex, dynamic data) {
    return null;
  }

  static Border? _defaultBorderBuilder(int rowIndex, dynamic data) {
    return null;
  }
}
