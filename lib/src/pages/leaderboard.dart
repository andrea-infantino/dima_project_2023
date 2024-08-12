import 'package:dima_project_2023/src/session_manager.dart';
import 'package:flutter/material.dart';
import '../../assets/colors.dart';
import '../db_snapshot.dart';
import '../widgets/containers.dart';
import '../widgets/text.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  Map<String, int> _local = {};

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(height: (Session.instance.deviceHeight) * (1 / 15)),
          Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Text('Leaderboard:',
                  style: MyTextStyle.get(
                    size: 50,
                    color: WATER_GREEN,
                    bold: true,
                    italic: true,
                  ))),
          const Divider(),
          TabBar(
              labelStyle: MyTextStyle.get(size: 30, bold: true, italic: true),
              labelColor: BLACK,
              tabs: const [
                Tab(
                  text: 'Global',
                ),
                Tab(text: 'Local'),
              ]),
          Expanded(
            child: ValueListenableBuilder<Map<String, int>>(
                valueListenable: DBsnapshot.instance.global,
                builder: (context, value, child) {
                  _loadLeaderboard();
                  return TabBarView(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ListView.builder(
                          itemCount: value.length,
                          itemBuilder: _buildGlobalListTile,
                        ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ListView.builder(
                          itemCount: _local.length,
                          itemBuilder: _buildLocalListTile,
                        ))
                      ],
                    )
                  ]);
                }),
          )
        ]));
  }

  void _loadLeaderboard() {
    for (var currEmail in DBsnapshot.instance.global.value.keys) {
      List<String> friends = DBsnapshot.instance.social.value["friends"]!;
      if (friends.contains(currEmail) ||
          currEmail.toLowerCase() == Session.instance.email) {
        _local[currEmail.toLowerCase()] =
            DBsnapshot.instance.global.value[currEmail]!;
      }
    }

    DBsnapshot.instance.global.value = Map.fromEntries(
        DBsnapshot.instance.global.value.entries.toList()
          ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    _local = Map.fromEntries(_local.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));
  }

  Widget _buildGlobalListTile(BuildContext context, index) {
    return _buildListTile(context, index, true);
  }

  Widget _buildLocalListTile(BuildContext context, index) {
    return _buildListTile(context, index, false);
  }

  Widget _buildListTile(BuildContext context, index, bool isGlobal) {
    late String username;
    late int score;
    int position = index + 1;
    if (isGlobal) {
      username = DBsnapshot.instance.global.value.keys.elementAt(index);
      score = DBsnapshot.instance.global.value.values.elementAt(index);
    } else {
      username = _local.keys.elementAt(index);
      score = _local.values.elementAt(index);
    }

    late Color color;
    switch (position) {
      case 1:
        {
          color = GOLD;
          break;
        }
      case 2:
        {
          color = SILVER;
          break;
        }
      case 3:
        {
          color = BRONZE;
          break;
        }
      default:
        {
          color = BLACK;
          break;
        }
    }

    late Color backgroundColor;
    if (username == Session.instance.email) {
      backgroundColor = LIGHT_YELLOW;
    } else {
      if (index % 2 == 0) {
        backgroundColor = LIGHT_WATER_GREEN;
      } else {
        backgroundColor = WATER_GREEN;
      }
    }

    return LeaderboardTile(
        backgroundColor: backgroundColor,
        color: color,
        position: position,
        username: username,
        score: score);
  }
}
