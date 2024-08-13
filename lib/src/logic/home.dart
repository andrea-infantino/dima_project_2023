import 'dart:async';
import 'package:dima_project_2023/src/db_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import '../pages/authentication/login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health/health.dart';
class HomeLogic {
  static void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<void> loadHealthData() async {
    Stream<StepCount> stepCountStream = await Pedometer.stepCountStream;
    await Permission.location.request();
    await Permission.activityRecognition.request();
    stepCountStream.listen((StepCount event) {
      print("Steps in your account are: ${event.steps}");
    });

    HealthFactory health = HealthFactory();
    int? steps = 0;
    var types = [HealthDataType.WATER, HealthDataType.HEART_RATE, HealthDataType.STEPS];
    var permissions = [HealthDataAccess.READ, HealthDataAccess.READ, HealthDataAccess.READ];
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day);
    await Permission.activityRecognition.request();
    await Permission.location.request();
    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);
    hasPermissions = false;
    // print("hasPermissions: $hasPermissions");
    if(!hasPermissions!){
      bool? authorized =
        await health.requestAuthorization(types);
      if(authorized!){
        print("authorized: $authorized");
        steps = await health.getTotalStepsInInterval(midnight, now);
        print('steps: $steps (${steps.runtimeType})');
        if(steps != null){
          updateMySteps(steps);
        }
        List<HealthDataPoint> list = await health.getHealthDataFromTypes(midnight, now, types);
        print('list: $list');
        for (var el in list) {
          print(el.typeString);
          switch (el.typeString) {
            case 'SLEEP_IN_BED':
              {
                var value = el.value as NumericHealthValue;
                print('sleep: ${value.numericValue}');
                // updateMySleep(value.numericValue.toInt());
                break;
              }
            case 'WATER':
              {
                var value = el.value as NumericHealthValue;
                double intValue = value.numericValue * 1000;
                updateMyWater(intValue.toInt());
                print('water: ${value.numericValue}');
                break;
              }
          }
        }
      }
    }
    // bool? hasPermissions =
    //     await health.hasPermissions(types, permissions: permissions);
    // bool authorized = false;
    //   // requesting access to the data types before reading them
    // if(!hasPermissions!){
    //   try{
    //     authorized = await health.requestAuthorization([HealthDataType.STEPS]);
    //     print("hasPermissions: $hasPermissions");
    //   }catch(e){
    //     print('Error occured: $e');
    //   }
    // }
    // int? steps = await health.getTotalStepsInInterval(midnight, now);
    // print('steps: $steps');
    // if (steps != null) {
    //   setState(() {
    //     _steps = steps;
    //   });
    // }
    // if (request) {
    //   late List<HealthDataPoint> healthData;
    //   healthData = await health.getHealthDataFromTypes(midnight, now, types);
    //   int water = 0, sleep = 0;
    //   healthData = HealthFactory.removeDuplicates(healthData);
    //   for (var el in healthData) {
    //     switch (el.typeString) {
    //       case 'SLEEP_IN_BED':
    //         {
    //           var value = el.value as NumericHealthValue;
    //           sleep = sleep + (value.numericValue * 1000).toInt();
    //           break;
    //         }
    //       case 'WATER':
    //         {
    //           var value = el.value as NumericHealthValue;
    //           water = water + (value.numericValue * 1000).toInt();
    //           break;
    //         }
    //     }
    //   }
    //   setState(() {
    //     _water = water;
    //     _sleep = sleep;
    //   });
    // }
  }
/*
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