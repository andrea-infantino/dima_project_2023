import 'dart:ui';

import 'package:dima_project_2023/src/db_snapshot.dart';
import 'package:dima_project_2023/src/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:dima_project_2023/src/pages/authentication/login.dart';

late int deviceType; // 0: Phone, 1: Tablet

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final double physicalWidth = PlatformDispatcher.instance.views.first.physicalSize.width;
  final double physicalHeight = PlatformDispatcher.instance.views.first.physicalSize.height;

  final double devicePixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;
    
  final double logicalWidth = physicalWidth / devicePixelRatio;
  final double logicalHeight = physicalHeight / devicePixelRatio;

  
  if (logicalHeight > logicalWidth) {
    deviceType = logicalWidth < 600 ? 0 : 1;
  }
  else {
    deviceType = logicalHeight < 600 ? 0 : 1;
  }

  if (deviceType == 0) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  Session.init();
  DBsnapshot.init();

  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Healthy Challenge',
        home: LoginPage());
  }
}
