import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataStateNotifier extends StateNotifier<List<dynamic>> {
  DataStateNotifier(List<dynamic> data) : super(data);

  List<dynamic> get currentState => state;
}
