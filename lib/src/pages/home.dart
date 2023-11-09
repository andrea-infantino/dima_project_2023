import 'package:dima_project_2023/src/pages/authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../assets/colors.dart';
import '../db_manager.dart';
import '../session_manager.dart';
import '../widgets/containers.dart';
import '../widgets/text.dart';

/// Stateful Widget of main Home Page with linking to Health package
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = '';
  int _steps = 0, _sleep = 0, _water = 0;
  int _score_steps = 0, _score_sleep = 0, _score_water = 0;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadHealthData().then((value) => _calculateScores());
  }

  Future<void> _loadUsername() async {
    _username = Session.instance.email.split('@')[0];
  }

  Future<void> _loadHealthData() async {
    /*HealthFactory health = HealthFactory();

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
    }*/
  }

  Future<void> incrementScore(int points) async {
    Session.instance.score.value += points;
    updateMyScore(Session.instance.score.value);
  }

  Future<void> _calculateScores() async {
    /*setState(() {
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
    }*/
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: (Session.instance.deviceHeight) * (1 / 15)),
            MyText(text: 'Hi $_username', size: 30, bold: true),
            TextButton(
                onPressed: (() {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }),
                child: const MyText(
                    text: 'Log-out', size: 15, color: WATER_GREEN)),
            const SizedBox(height: 20),
            ValueListenableBuilder<int>(
                valueListenable: Session.instance.score,
                builder: (context, value, child) {
                  return ScoreContainer(score: Session.instance.score.value);
                }),
            Container(height: 20),
            const Divider(),
            const MyText(text: 'Activities:', size: 30, bold: true),
            Expanded(
                child: ListView(
              children: [
                ActivityTile(
                  activityName: 'Steps',
                  udm: '',
                  activityValue: _steps,
                  score: _score_steps,
                  icon: Icons.nordic_walking,
                ),
                ActivityTile(
                  activityName: 'Hydratation',
                  udm: 'mL',
                  activityValue: _water,
                  score: _score_water,
                  icon: Icons.fitness_center,
                ),
                ActivityTile(
                    activityName: 'Sleep',
                    udm: 'h',
                    activityValue: _sleep,
                    score: _score_sleep,
                    icon: Icons.nightlight),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
