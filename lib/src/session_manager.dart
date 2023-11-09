import 'package:dima_project_2023/src/db_manager.dart';
import 'package:flutter/cupertino.dart';

class Session {
  static late Session _session;
  late String _email, _uid;
  late double _deviceHeight, _deviceWidth;

  ValueNotifier<Map<String, List<String>>> social =
      ValueNotifier({"friends": [], "requests": []});
  ValueNotifier<Map<String, int>> global = ValueNotifier({});
  ValueNotifier<String> last_login = ValueNotifier("");
  ValueNotifier<int> score = ValueNotifier(0);
  ValueNotifier<int> sleep = ValueNotifier(0);
  ValueNotifier<int> steps = ValueNotifier(0);
  ValueNotifier<int> water = ValueNotifier(0);

  static void init(double deviceHeight, double deviceWidth) {
    _session = Session._internal(deviceHeight, deviceWidth);
  }

  Future<void> setUser(String email, String uid) async {
    _email = email;
    _uid = uid;
    await loadDB();
  }

  Session._internal(double deviceHeight, double deviceWidth) {
    _deviceHeight = deviceHeight;
    _deviceWidth = deviceWidth;
  }

  static Session get instance => _session;

  String get email => _email;

  String get uid => _uid;

  double get deviceHeight => _deviceHeight;

  double get deviceWidth => _deviceWidth;
}
