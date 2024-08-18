import 'package:dima_project_2023/src/logic/authentication/login.dart';
import 'package:dima_project_2023/src/widgets/dialog_windows.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/pages_manager.dart';
import '../../session_manager.dart';
import '../achievements.dart';

class RegistrationLogic {
  static Future<void> register(BuildContext context, String email,
      String password, String passwordChecker) async {
    if (password != passwordChecker) {
      _passwordDontMatch(context);
      return;
    }
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
              Session.instance.setUser(value.user!.email!, value.user!.uid);
              LoginLogic.prefs.setString('email', email);
              LoginLogic.prefs.setString('password', password);
          })
          .then((value) => Achievements.init())
          .then((value) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PagesManager()),
              ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _passwordTooShort(context);
      } else if (e.code == 'email-already-in-use') {
        _alreadyRegistered(context);
      }
    }
  }

  static void _passwordDontMatch(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const OkDialog(
            title: 'Registration Failed', content: 'Passwords do not match.'));
  }

  static void _passwordTooShort(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const OkDialog(
            title: 'Registration Failed',
            content: 'Password must be at least 6 characters long.'));
  }

  static void _alreadyRegistered(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const OkDialog(
            title: 'Registration Failed',
            content: 'This email is already registered.'));
  }
}
