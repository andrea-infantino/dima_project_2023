// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCU_uIzzvCfMpsO3uj7djO01TUiLHqeRu4',
    appId: '1:445585836964:web:91b8b0477ae400b1074f31',
    messagingSenderId: '445585836964',
    projectId: 'dima-project-2023',
    authDomain: 'dima-project-2023.firebaseapp.com',
    databaseURL: 'https://dima-project-2023-default-rtdb.firebaseio.com',
    storageBucket: 'dima-project-2023.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWhIVmBOosmLuiByT4Lafk4R4oUbSTHkE',
    appId: '1:445585836964:android:8353a6b0cf127f43074f31',
    messagingSenderId: '445585836964',
    projectId: 'dima-project-2023',
    databaseURL: 'https://dima-project-2023-default-rtdb.firebaseio.com',
    storageBucket: 'dima-project-2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKnp3htRd3p3QygVip4f3Q7RJP7lUZ9zg',
    appId: '1:445585836964:ios:56ff00a94c100ebb074f31',
    messagingSenderId: '445585836964',
    projectId: 'dima-project-2023',
    databaseURL: 'https://dima-project-2023-default-rtdb.firebaseio.com',
    storageBucket: 'dima-project-2023.appspot.com',
    iosBundleId: 'com.example.dimaProject2023',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBKnp3htRd3p3QygVip4f3Q7RJP7lUZ9zg',
    appId: '1:445585836964:ios:56ff00a94c100ebb074f31',
    messagingSenderId: '445585836964',
    projectId: 'dima-project-2023',
    databaseURL: 'https://dima-project-2023-default-rtdb.firebaseio.com',
    storageBucket: 'dima-project-2023.appspot.com',
    iosBundleId: 'com.example.dimaProject2023',
  );
}
