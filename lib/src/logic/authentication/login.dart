import 'package:dima_project_2023/src/widgets/dialog_windows.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../pages/pages_manager.dart';
import '../../session_manager.dart';
import '../achievements.dart';

class LoginLogic {
  
  static late SharedPreferences prefs;

  static Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
              Session.instance.setUser(value.user!.email!, value.user!.uid);
              prefs.setString('email', email);
              prefs.setString('password', password);
          })
          .then((value) => Achievements.init())
          .then((value) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PagesManager()),
              ));
    } on FirebaseAuthException {
      _invalidCredentials(context);
    }
  }

  static void _invalidCredentials(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const OkDialog(
            title: 'Login Failed', content: 'Invalid email or password.'));
  }

  static Future<List<String>?> checkLoginStatus() async {
    prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    String? savedAccessToken = prefs.getString('accessToken');
    String? savedIdToken = prefs.getString('idToken');

    if (savedEmail != null && savedPassword != null) {      
      prefs.remove('accessToken');
      prefs.remove('idToken');
      return List<String>.from(<String>['email', savedEmail, savedPassword]);
    }

    if (savedAccessToken != null && savedIdToken != null) {      
      prefs.remove('email');
      prefs.remove('password');
      return List<String>.from(<String>['google', savedAccessToken, savedIdToken]);
    }

    return null;
  }

  static Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      signInWithTokens(context, googleAuth.accessToken!, googleAuth.idToken!);
    } else {
      _googleSignInFailed(context);
    }
  }

  static void _googleSignInFailed(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const OkDialog(
            title: 'Google Sign-in Failed', content: 'An unexpected error occured'));
  }

  static Future<void> signInWithTokens(BuildContext context, String accessToken, String idToken) async {
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          print('email ${user.email} uid ${user.uid}');
          Session.instance.setUser(user.email!, user.uid);
          prefs.setString('accessToken', accessToken);
          prefs.setString('idToken', idToken); 

          Achievements.init();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PagesManager()),
          );
        }
      } on FirebaseAuthException {
        _googleSignInFailed(context);
      }
  }
}
