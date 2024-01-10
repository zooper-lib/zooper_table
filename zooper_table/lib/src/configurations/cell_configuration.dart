import 'package:flutter/widgets.dart';

class CellConfiguration<TData> {
  /// Builds a cell for the table.
  ///
  /// The [cellBuilder] function is responsible for creating a `CellBase` object for each cell in the table.
  /// It is called with three arguments:
  /// - [data]: The data for the row. The type of this data is defined by the generic parameter `TData`.
  /// - [identifier]: The identifier of the column that this cell belongs to.
  ///
  /// The function should return a `CellBase` object that represents the cell.
  //final ZooperCellView Function(TData data, String identifier) cellBuilder;

  final String Function(TData data, String identifier) cellValue;

  /// Builds the padding for the cell.
  final EdgeInsets Function(TData data, String identifier, int index) paddingBuilder;

  CellConfiguration({
    required this.cellValue,
    EdgeInsets Function(TData data, String identifier, int index)? paddingBuilder,
  }) : paddingBuilder = paddingBuilder ?? _defaultPaddingBuilder;

  static EdgeInsets _defaultPaddingBuilder<TData>(TData data, String identifier, int index) {
    return const EdgeInsets.all(4);
  }
}
