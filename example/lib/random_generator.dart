import 'dart:math';

class RandomGenerator {
  static final random = Random();

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(random.nextInt(_chars.length))));
}
