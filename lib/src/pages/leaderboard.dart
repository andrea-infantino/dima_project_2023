import 'package:dima_project_2023/src/session_manager.dart';
import 'package:flutter/material.dart';

import '../../assets/colors.dart';
import '../db_manager.dart';
import '../widgets/containers.dart';
import '../widgets/text.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  Map<String, int> _local = {};

  void _reloadLeaderboard() {
    for (var currEmail in Session.instance.global.value.keys) {
      List<String> friends = Session.instance.social.value["friends"]!;
      if (friends.contains(currEmail) ||
          currEmail.toLowerCase() == Session.instance.email) {
        _local[currEmail.toLowerCase()] =
            Session.instance.global.value[currEmail]!;
      }
    }

    Session.instance.global.value = Map.fromEntries(
        Session.instance.global.value.entries.toList()
          ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    _local = Map.fromEntries(_local.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(height: (Session.instance.deviceHeight) * (1 / 15)),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: MyText(
              text: 'Leaderboard:',
              size: 50,
              color: GREEN,
              italic: true,
              bold: true,
            ),
          ),
          const Divider(),
          const TabBar(
              labelStyle: TextStyle(
                fontSize: 30,
                fontFamily: 'Exo2',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                shadows: <Shadow>[
                  Shadow(
                    color: GREY,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              labelColor: BLACK,
              tabs: [
                Tab(
                  text: 'Global',
                ),
                Tab(text: 'Local'),
              ]),
          Expanded(
            child: ValueListenableBuilder<Map<String, int>>(
                valueListenable: Session.instance.global,
                builder: (context, value, child) {
                  _reloadLeaderboard();
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
      username = Session.instance.global.value.keys.elementAt(index);
      score = Session.instance.global.value.values.elementAt(index);
    } else {
      username = _local.keys.elementAt(index);
      score = _local.values.elementAt(index);
    }

    late Color color;
    switch (position) {
      case 1:
        {
          color = const Color.fromARGB(255, 212, 175, 55);
          break;
        }
      case 2:
        {
          color = const Color.fromARGB(255, 170, 169, 173);
          break;
        }
      case 3:
        {
          color = const Color.fromARGB(255, 179, 116, 66);
          break;
        }
      default:
        {
          color = Colors.black;
          break;
        }
    }

    late Color backgroundColor;
    if (username == Session.instance.email) {
      backgroundColor = const Color.fromARGB(100, 255, 255, 0);
    } else {
      if (index % 2 == 0) {
        backgroundColor = const Color.fromARGB(80, 49, 196, 141);
      } else {
        backgroundColor = const Color.fromARGB(160, 49, 196, 141);
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
