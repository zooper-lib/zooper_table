class RowData {
  final String rowIdentifier;

  dynamic data;
  bool isSelected;

  RowData({
    required this.rowIdentifier,
    required this.data,
    this.isSelected = false,
  });

  @override
  String toString() {
    return 'ZooperRowModel{identifier: $rowIdentifier, isSelected: $isSelected}';
  }
}
