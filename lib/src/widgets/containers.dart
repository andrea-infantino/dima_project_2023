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
          Text('$score',
              style: MyTextStyle.get(size: 45, color: ORANGE, bold: true)),
          //const SizedBox(height: 20),
          Text('Beats',
              style: MyTextStyle.get(
                size: 20,
                color: WATER_GREEN,
              ))
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
                Icon(icon, size: 30, color: WATER_GREEN),
                Container(width: 20),
                Text(activityName, style: MyTextStyle.get(size: 25))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$activityValue $udm', style: MyTextStyle.get(size: 25)),
                Text('+$score Beats',
                    style: MyTextStyle.get(size: 15, color: WATER_GREEN))
              ],
            )
          ],
        ));
  }
}

class LeaderboardTile extends StatelessWidget {
  final Color backgroundColor, color;
  final String username;
  final int position, score;

  const LeaderboardTile(
      {super.key,
      required this.backgroundColor,
      required this.color,
      required this.position,
      required this.username,
      required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('$position°:',
                          style: MyTextStyle.get(size: 15, color: color)),
                      Container(width: 15),
                      Text(username, style: MyTextStyle.get(size: 15))
                    ],
                  ),
                  Text('$score Beats', style: MyTextStyle.get(size: 15))
                ])));
  }
}
