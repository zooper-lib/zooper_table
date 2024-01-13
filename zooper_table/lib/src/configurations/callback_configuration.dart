import 'package:zooper_table/zooper_table.dart';

class CallbackConfiguration {
  /// A callback that notifies when a column is sorted.
  ///
  /// This optional callback is invoked when sorting is applied to a column. It serves as a
  /// notification mechanism, allowing users to respond to the sort event.
  ///
  /// Parameters:
  /// - [columnIdentifier]: A string representing the identifier of the sorted column.
  /// - [sortOrder]: The [SortOrder] indicating the direction of the sort (ascending or descending).
  ///
  /// This callback is `null` by default. When implemented, it can be used to perform actions or
  /// updates in response to the sorting of a column, such as updating data or UI elements accordingly.
  final void Function(String columnIdentifier, SortOrder sortOrder)? onColumnSort;

  /// A callback that notifies when a row has been reordered.
  ///
  /// This optional callback is invoked after a row has been successfully reordered. It serves as
  /// a notification mechanism, allowing users to respond to the reorder event.
  ///
  /// Parameters:
  /// - [data]: The dynamic data associated with the row that has been reordered.
  /// - [oldIndex]: An integer representing the row's original index before the reordering.
  /// - [newIndex]: An integer representing the row's new index after the reordering.
  ///
  /// This callback is `null` by default. When implemented, it can be used to perform actions or
  /// updates in response to the row's reordering, without handling the reordering logic itself.
  final void Function(dynamic data, int oldIndex, int newIndex)? onRowReorder;

  /// A callback that notifies when a row is selected.
  ///
  /// This optional callback is invoked when a row is selected by the user. It serves as a
  /// notification mechanism, allowing users to respond to the selection event.
  ///
  /// Parameters:
  /// - [data]: The dynamic data associated with the selected row.
  /// - [rowIndex]: An integer representing the index of the selected row.
  ///
  /// This callback is `null` by default. When implemented, it can be used to perform actions or
  /// updates in response to the selection of a row, such as updating UI elements or processing
  /// data related to the selected row.
  final void Function(dynamic data, int rowIndex)? onRowSelected;

  CallbackConfiguration({
    this.onColumnSort,
    this.onRowReorder,
    this.onRowSelected,
  });
}
