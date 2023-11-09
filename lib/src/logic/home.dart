import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/authentication/login.dart';

class HomeLogic {
  static void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

/*
  Future<void> _loadHealthData() async {
    HealthFactory health = HealthFactory();

    var types = [HealthDataType.WATER, HealthDataType.SLEEP_IN_BED];
    var permissions = [HealthDataAccess.READ, HealthDataAccess.READ];

    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day);

    bool request =
        await health.requestAuthorization(types, permissions: permissions);
    await Permission.activityRecognition.request();
    await Permission.location.request();

    int? steps = await health.getTotalStepsInInterval(midnight, now);
    if (steps != null) {
      setState(() {
        _steps = steps;
      });
    }
    if (request) {
      late List<HealthDataPoint> healthData;
      healthData = await health.getHealthDataFromTypes(midnight, now, types);
      int water = 0, sleep = 0;
      healthData = HealthFactory.removeDuplicates(healthData);
      for (var el in healthData) {
        switch (el.typeString) {
          case 'SLEEP_IN_BED':
            {
              var value = el.value as NumericHealthValue;
              sleep = sleep + (value.numericValue * 1000).toInt();
              break;
            }
          case 'WATER':
            {
              var value = el.value as NumericHealthValue;
              water = water + (value.numericValue * 1000).toInt();
              break;
            }
        }
      }
      setState(() {
        _water = water;
        _sleep = sleep;
      });
    }
  }

  Future<void> incrementScore(int points) async {
    DBsnapshot.instance.score.value += points;
    updateMyScore(DBsnapshot.instance.score.value);
  }

  Future<void> _calculateScores() async {
    setState(() {
      _score_steps = ((_steps / 1000) - 0.5).round();
    });
    setState(() {
      _score_sleep = (_sleep - 0.5).round();
    });
    setState(() {
      _score_water = ((_water / 100) - 0.5).round();
    });

    int p_steps = await getMySteps();
    int p_sleep = await getMySleep();
    int p_water = await getMyWater();

    int score_steps = (((_steps - p_steps) / 1000) - 0.5).round();
    int score_sleep = ((_sleep - p_sleep) - 0.5).round();
    int score_water = (((_water - p_water) / 100) - 0.5).round();

    if (score_steps > 0) {
      updateMySteps(score_steps);
    }
    if (score_sleep > 0) {
      updateMySleep(score_sleep);
    }
    if (score_water > 0) {
      updateMyWater(score_water);
    }
  }*/

}
