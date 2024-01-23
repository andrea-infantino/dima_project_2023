import 'package:dima_project_2023/src/db_snapshot.dart';
import 'package:dima_project_2023/src/logic/home.dart';
import 'package:dima_project_2023/src/pages/authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../assets/colors.dart';
import '../session_manager.dart';
import '../widgets/containers.dart';
import '../widgets/text.dart';
import '../logic/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _steps = 0, _sleep = 0, _water = 0;
  int _score_steps = 0, _score_sleep = 0, _score_water = 0;
  
  @override
  void initState() {
    super.initState();
    HomeLogic homeLogic = HomeLogic();
    homeLogic.loadHealthData();
  }
  void updateState(int steps, int sleep, int water) {
    setState(() {
      _steps = steps;
      _sleep = sleep;
      _water = water;
    });
  }

  @override
  Widget build(context) {
    String username = Session.instance.email.split('@')[0];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: (Session.instance.deviceHeight) * (1 / 15)),
            Text('Hi $username', style: MyTextStyle.get(size: 30, bold: true)),
            TextButton(
                onPressed: () => HomeLogic.logout(context),
                child: Text('Log-out',
                    style: MyTextStyle.get(size: 15, color: WATER_GREEN))),
            const SizedBox(height: 20),
            ValueListenableBuilder<int>(
                valueListenable: DBsnapshot.instance.score,
                builder: (context, value, child) {
                  return ScoreContainer(score: DBsnapshot.instance.score.value);
                }),
            Container(height: 20),
            const Divider(),
            Text('Activities:',
                style: MyTextStyle.get(
                  size: 30,
                  bold: true,
                )),
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
