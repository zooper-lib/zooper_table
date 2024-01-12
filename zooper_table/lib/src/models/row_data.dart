class RowData {
  final String identifier;

  dynamic data;
  bool isSelected;

  RowData({
    required this.identifier,
    required this.data,
    this.isSelected = false,
  });

  @override
  String toString() {
    return 'ZooperRowModel{identifier: $identifier, isSelected: $isSelected}';
  }
}
