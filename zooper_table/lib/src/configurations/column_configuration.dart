class ColumnConfiguration {
  final double Function(String identifier) minWidthBuilder;

  final double Function(String identifier) maxWidthBuilder;

  /// Callback if the column can be sorted.
  final bool Function(String identifier) canSortBuilder;

  ColumnConfiguration({
    double Function(String identifier)? minWidthBuilder,
    double Function(String identifier)? maxWidthBuilder,
    bool Function(String identifier)? canSort,
  })  : minWidthBuilder = minWidthBuilder ?? _defaultMinWidthBuilder,
        maxWidthBuilder = maxWidthBuilder ?? _defaultMaxWidthBuilder,
        canSortBuilder = canSort ?? _defaultCanSortBuilder;

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
}
