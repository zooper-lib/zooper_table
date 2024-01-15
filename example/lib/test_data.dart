// ignore_for_file: prefer_final_fields

class TestData {
  String _id;
  String _name;
  int _age;
  double _height;

  TestData({
    required String id,
    required String name,
    required int age,
    required double height,
  })  : _id = id,
        _name = name,
        _age = age,
        _height = height;

  String get id => _id;
  String get name => _name;
  int get age => _age;
  double get height => _height;
}
