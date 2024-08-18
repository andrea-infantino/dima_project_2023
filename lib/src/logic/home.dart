import 'dart:async';
import 'package:dima_project_2023/src/db_manager.dart';
import 'package:dima_project_2023/src/logic/authentication/link_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../pages/authentication/login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health/health.dart';

import 'authentication/login.dart';

class HomeLogic {
  Timer? _healthDataTimer;

  get healthDataTimer => _healthDataTimer;

  static void logout(BuildContext context , Timer? healthDataTimer) {
    healthDataTimer?.cancel();
    healthDataTimer = null;
    FirebaseAuth.instance.signOut();
    
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();

    LoginLogic.prefs.remove('email');
    LoginLogic.prefs.remove('password');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<void> loadHealthData() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    linkEmailGoogle();
    
    HealthFactory health = HealthFactory();
    var types = [HealthDataType.WATER, HealthDataType.SLEEP_ASLEEP, HealthDataType.STEPS];
    var permissions = [HealthDataAccess.READ, HealthDataAccess.READ, HealthDataAccess.READ];
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day);

    bool? hasPermissions = await health.hasPermissions(types, permissions: permissions);
    hasPermissions = false;

    if (!hasPermissions) {
      bool? authorized = await health.requestAuthorization(types);
      if (authorized) {
        // Call the method immediately
        await fetchAndUpdateHealthData(health, midnight, now, types);

        // Start the timer loop
        _healthDataTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
          now = DateTime.now();
          await fetchAndUpdateHealthData(health, midnight, now, types);
        });
      }
    }
  }

  Future<void> fetchAndUpdateHealthData(HealthFactory health, DateTime midnight, DateTime now, List<HealthDataType> types) async {
    int? steps = 0;
    double totalWater = 0;
    int totalSleep = 0;
    steps = await health.getTotalStepsInInterval(midnight, now);
    // print('steps: $steps (${steps.runtimeType})');
    if (steps != null) {
      updateMySteps(steps);
    }

    List<HealthDataPoint> list = await health.getHealthDataFromTypes(midnight, now, types);
    print('list: $list');
    for (var el in list) {
      print(el.typeString);
      switch (el.typeString) {
        case 'SLEEP_ASLEEP':
          {
            var value = el.value as NumericHealthValue;
            totalSleep += (value.numericValue / 60).ceil();
            break;
          }
        case 'WATER':
          {
            var value = el.value as NumericHealthValue;
            totalWater += value.numericValue * 1000;
            break;
          }
      }
    }
    updateMySleep(totalSleep);
    updateMyWater(totalWater.toInt());
  }
}