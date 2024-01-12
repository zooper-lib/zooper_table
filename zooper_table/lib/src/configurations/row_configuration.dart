import 'package:zooper_table/zooper_table.dart';

class RowConfiguration {
  final String Function(int index, dynamic data) identifierBuilder;

  final double? Function(String identifier, int index) heightBuilder;

  final void Function(ZooperRowModel row)? onRowTap;

  final bool Function() isReorderingEnabledBuilder;

  RowConfiguration({
    String Function(int index, dynamic data)? identifierBuilder,
    double Function(String identifier, int index)? heightBuilder,
    this.onRowTap,
    bool Function()? isReorderingEnabledBuilder,
  })  : identifierBuilder = identifierBuilder ?? _defaultIdentifierBuilder,
        heightBuilder = heightBuilder ?? _defaultHeightBuilder,
        isReorderingEnabledBuilder = isReorderingEnabledBuilder ?? _defaultIsReorderingEnabledBuilder;

  static String _defaultIdentifierBuilder(int index, dynamic data) {
    return index.toString();
  }

  // Default minWidth builder
  static double? _defaultHeightBuilder(String identifier, int index) {
    return null;
  }

  static bool _defaultIsReorderingEnabledBuilder() {
    return true;
  }
}
