import 'package:dima_project_2023/src/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:dima_project_2023/src/pages/authentication/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp( 
    // name: 'Healthy Challenge',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Healthy Challenge',
        home: Redirect());
  }
}

class Redirect extends StatefulWidget {
  @override
  _RedirectState createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Session.init(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Check if a session can be taken, otherwise:
    return const LoginPage();
  }
}
