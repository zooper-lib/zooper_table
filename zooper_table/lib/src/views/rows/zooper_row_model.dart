class ZooperRowModel {
  final String identifier;
  int order;
  dynamic data;
  bool isSelected;

  ZooperRowModel({
    required this.identifier,
    required this.order,
    required this.data,
    this.isSelected = false,
  });
}