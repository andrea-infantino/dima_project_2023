import 'package:dima_project_2023/src/db_manager.dart';

class Session {
  static late Session _session;
  late String _email, _uid;

  static void init() {
    _session = Session._internal();
    _session._email = '';
    _session._uid = '';
  }

  Future<void> setUser(String email, String uid) async {
    print('Setting user: $email, $uid');
    _session._email = email;
    _session._uid = uid;
    await initDB();
  }

  Session._internal();

  static Session get instance => _session;

  String get email => _email;

  String get uid => _uid;
}
