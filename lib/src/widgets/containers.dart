import 'package:dima_project_2023/assets/colors.dart';
import 'package:flutter/material.dart';

import 'text.dart';

class ScoreContainer extends StatelessWidget {
  final int score;

  const ScoreContainer({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        'lib/assets/images/left-wing.png',
        height: 70,
        scale: 2.5,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(text: '$score', size: 45, color: ORANGE, bold: true),
          //const SizedBox(height: 20),
          const MyText(
            text: 'Beats',
            size: 20,
            color: GREEN,
          )
        ],
      ),
      Image.asset(
        'lib/assets/images/right-wing.png',
        height: 70,
        scale: 2.5,
      ),
    ]);
  }
}

class ActivityTile extends StatelessWidget {
  final String activityName;
  final String udm;
  final int activityValue;
  final int score;
  final IconData icon;
  const ActivityTile(
      {super.key,
      required this.activityName,
      required this.udm,
      required this.activityValue,
      required this.icon,
      required this.score});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, size: 30, color: GREEN),
                Container(width: 20),
                MyText(
                  text: activityName,
                  size: 25,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: '$activityValue $udm',
                  size: 25,
                ),
                MyText(
                  text: '+ $score Beats',
                  size: 15,
                  color: GREEN,
                )
              ],
            )
          ],
        ));
  }
}
