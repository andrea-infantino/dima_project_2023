import 'package:dima_project_2023/src/db_snapshot.dart';
import 'package:dima_project_2023/src/logic/home.dart';
import 'package:flutter/material.dart';
import '../../assets/colors.dart';
import '../session_manager.dart';
import '../widgets/containers.dart';
import '../widgets/text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _score_steps = 0, _score_sleep = 0, _score_water = 0;

  @override
  void initState() {
    super.initState();
    HomeLogic homeLogic = HomeLogic();
    homeLogic.loadHealthData();
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
                ValueListenableBuilder<int>(
                    valueListenable: DBsnapshot.instance.steps,
                    builder: (context, value, child) {
                      int val = DBsnapshot.instance.steps.value;
                      int score = val ~/ 100;
                      return ActivityTile(
                        activityName: 'Steps',
                        udm: '',
                        activityValue: val,
                        score: score,
                        icon: Icons.nordic_walking,
                      );
                    }),
                ValueListenableBuilder<int>(
                    valueListenable: DBsnapshot.instance.water,
                    builder: (context, value, child) {
                      int val = DBsnapshot.instance.water.value;
                      int score = val ~/ 100;
                      return ActivityTile(
                        activityName: 'Hydratation',
                        udm: 'mL',
                        activityValue: val,
                        score: score,
                        icon: Icons.fitness_center,
                      );
                    }),
                ValueListenableBuilder<int>(
                    valueListenable: DBsnapshot.instance.sleep,
                    builder: (context, value, child) {
                      int val = DBsnapshot.instance.sleep.value;
                      int score = val.floor();
                      return ActivityTile(
                          activityName: 'Sleep',
                          udm: 'h',
                          activityValue: val,
                          score: score,
                          icon: Icons.nightlight);
                    }),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
