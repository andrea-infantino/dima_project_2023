import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import '../mock.dart'; // from: https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_auth/firebase_auth/test/mock.dart



void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
}