class RowConfiguration<TData> {
  final double? Function(int index) heightBuilder;

  /// The height of each row.
  ///
  /// This is the base value, but it can be overriden by the callback inside [BasicRow]
  //final double rowHeight;

  /// Callback for when a row is tapped.
  ///
  /// The callback will be called with the data of the row that was tapped.
  /// You can override this callback for each [BasicRow]
  final Future<void> Function(TData data)? onRowTap;

  RowConfiguration({
    double Function(int index)? heightBuilder,
    this.onRowTap,
  }) : heightBuilder = heightBuilder ?? _defaultHeightBuilder;

  // Default minWidth builder
  static double? _defaultHeightBuilder(int index) {
    return null;
  }
}
