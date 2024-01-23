import 'package:dima_project_2023/src/db_manager.dart';

class Session {
  static late Session _session;
  late String _email, _uid;
  late double _deviceHeight, _deviceWidth;

  static void init(double deviceHeight, double deviceWidth) {
    _session = Session._internal(deviceHeight, deviceWidth);
    _session._email = '';
    _session._uid = '';

  }

  Future<void> setUser(String email, String uid) async {
    _session._email = email;
    _session._uid = uid;
    await initDB();
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
