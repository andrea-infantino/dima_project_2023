import 'package:dima_project_2023/src/logic/achievements.dart';

import '../../assets/colors.dart';
import '../db_snapshot.dart';
import '../session_manager.dart';
import 'package:flutter/material.dart';
import '../widgets/containers.dart';
import '../widgets/text.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<StatefulWidget> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  late List<Achievement> _all;

  @override
  Widget build(context) {
    return ValueListenableBuilder<List<int>>(
        valueListenable: DBsnapshot.instance.achievements,
        builder: (context, value, child) {
          Achievements.init();
          List<Achievement> completed = Achievements.instance.completed;
          List<Achievement> active = Achievements.instance.active;
          _all = active + completed;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: (Session.instance.deviceHeight) * (1 / 15)),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Achievements:',
                        style: MyTextStyle.get(
                          size: 50,
                          color: WATER_GREEN,
                          bold: true,
                          italic: true,
                        )),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                  child: ListView.builder(
                itemCount: _all.length,
                itemBuilder: _buildAchievementsListTile,
              )),
            ],
          );
        });
  }

  Widget _buildAchievementsListTile(BuildContext context, index) {
    Achievement achievement = _all[index];

    late Color backgroundColor;
    if (index % 2 == 0) {
      backgroundColor = LIGHT_WATER_GREEN;
    } else {
      backgroundColor = WATER_GREEN;
    }

    return AchievementTile(
      description: achievement.description,
      backgroundColor: backgroundColor,
      currValue: achievement.currValue,
      maxValue: achievement.maxValue,
    );
  }
}
