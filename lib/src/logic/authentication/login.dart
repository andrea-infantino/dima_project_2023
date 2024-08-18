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
    } on FirebaseAuthException catch (error){
      _invalidCredentials(context, error);
    }
  }

  static void _invalidCredentials(BuildContext context, FirebaseAuthException error) {
    showDialog(
        context: context,
        builder: (context) => const OkDialog(
            title: 'Login Failed', content: 'Invalid email or password.'));
  }

  static Future<List<String>?> checkLoginStatus() async {
    prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    if (savedEmail != null && savedPassword != null) {      
      return List<String>.from(<String>[savedEmail, savedPassword]);
    }

    return null;
  }

  static Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          print('email ${user.email} uid ${user.uid}');
          Session.instance.setUser(user.email!, user.uid);
          prefs.setString('email', user.email!);
          prefs.setString('password', ''); // Password is not available for Google sign-in

          Achievements.init();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PagesManager()),
          );
        }
      } on FirebaseAuthException catch (error) {
        _invalidCredentials(context, error);
      }
    } else {
      print("Google Sign-In failed");
    }
  }
}
