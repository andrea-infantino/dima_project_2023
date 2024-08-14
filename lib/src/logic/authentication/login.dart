import 'package:dima_project_2023/src/logic/authentication/link_google.dart';
import 'package:dima_project_2023/src/widgets/dialog_windows.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/pages_manager.dart';
import '../../session_manager.dart';
import '../achievements.dart';

class LoginLogic {
  static Future<void> login(
      BuildContext context, String email, String password) async {
      Session.init(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              Session.instance.setUser(value.user!.email!, value.user!.uid))
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
    print(error);
    showDialog(
        context: context,
        builder: (context) => const OkDialog(
            title: 'Login Failed', content: 'Invalid email or password.'));
  }
}
