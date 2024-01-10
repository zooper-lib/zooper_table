class ZooperColumnModel {
  final String identifier;
  final String title;
  int order;
  double width;

  ZooperColumnModel({
    required this.identifier,
    required this.title,
    required this.order,
    this.width = 100,
  });
}
