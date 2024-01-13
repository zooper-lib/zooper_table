import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';

/// A configuration class for a row in the Zooper table.
///
/// Allows customization of row identifiers, height, tap actions, and drag configurations.
class RowConfiguration {
  RowConfiguration({
    String Function(int index, dynamic data)? identifierBuilder,
    double? Function(String identifier, int index)? heightBuilder,
    Color Function(String identifier, int index)? selectedBackgroundColorBuilder,
    Border Function(String identifier, int index, bool isSelected)? borderBuilder,
    Widget Function(int rowIndex)? separatorBuilder,
    RowDragConfiguration? rowDragConfiguration,
  })  : identifierBuilder = identifierBuilder ?? _defaultIdentifierBuilder,
        heightBuilder = heightBuilder ?? _defaultHeightBuilder,
        selectedBackgroundColorBuilder = selectedBackgroundColorBuilder ?? _defaultSelectedBackgroundColorBuilder,
        borderBuilder = borderBuilder ?? _defaultBorderBuilder,
        separatorBuilder = separatorBuilder ?? _defaultSeparatorBuilder,
        rowDragConfiguration = rowDragConfiguration ?? RowDragConfiguration();

  /// Builder function to create a unique identifier for each row
  final String Function(int index, dynamic data) identifierBuilder;

  /// Builder function to determine the height of each row based on its identifier and index
  final double? Function(String identifier, int index) heightBuilder;

  /// Builder function to determine the background color if a row is selected
  final Color Function(String identifier, int index) selectedBackgroundColorBuilder;

  final Border? Function(String identifier, int index, bool isSelected) borderBuilder;

  final Widget Function(int rowIndex) separatorBuilder;

  /// Configuration for row drag behavior
  final RowDragConfiguration rowDragConfiguration;

  /// Default identifier builder that uses the row index
  static String _defaultIdentifierBuilder(int index, dynamic data) {
    return index.toString();
  }

  /// Default height builder returning null, indicating no specific height
  static double? _defaultHeightBuilder(String identifier, int index) {
    return 40;
  }

  static Color _defaultSelectedBackgroundColorBuilder(String identifier, int index) {
    return Colors.grey.withOpacity(0.2);
  }

  static Border? _defaultBorderBuilder(String identifier, int index, bool isSelected) {
    return null;
  }

  static Widget _defaultSeparatorBuilder(int rowIndex) {
    return Container(
      height: 1,
      color: Colors.grey.shade300,
    );
  }
}
