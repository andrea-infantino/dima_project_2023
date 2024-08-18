import 'package:dima_project_2023/src/logic/friends.dart';

import '../../assets/colors.dart';
import '../db_snapshot.dart';
import 'package:flutter/material.dart';
import '../widgets/text.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<StatefulWidget> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final TextEditingController _textFieldController = TextEditingController();
  String _valueText = '';
  Color _color = RED;

  @override
  Widget build(context) {
    return ValueListenableBuilder<Map<String, List<String>>>(
        valueListenable: DBsnapshot.instance.social,
        builder: (context, value, child) {
          Widget content;
          int friendsNumber = value["friends"]!.length;
          if (value["requests"]!.isEmpty) {
            content = Column(children: [
              Text('Friends:  [$friendsNumber]',
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Exo2',
                    fontWeight: FontWeight.bold,
                    color: WATER_GREEN,
                    shadows: <Shadow>[
                      Shadow(
                        color: GREY,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  )),
              const Divider(),
              Expanded(
                  child: ListView.builder(
                itemCount: value["friends"]!.length,
                itemBuilder: _buildFriendListTile,
              )),
            ]);
          } else {
            int ratioR = value["requests"]!.length;
            int ratioF = 0;
            if (value["friends"]!.length > (4 * ratioR)) {
              ratioF = 4 * ratioR;
            } else {
              ratioF = value["friends"]!.isEmpty ? 1 : value["friends"]!.length;
            }
            content = Column(children: [
              Text('Requests:',
                  style: MyTextStyle.get(
                      size: 20, bold: true, color: WATER_GREEN)),
              const Divider(),
              Expanded(
                  flex: ratioR,
                  child: ListView.builder(
                    itemCount: value["requests"]!.length,
                    itemBuilder: _buildRequestListTile,
                  )),
              const Divider(),
              Text('Friends: [$friendsNumber]',
                  style: MyTextStyle.get(
                      size: 20, bold: true, color: WATER_GREEN)),
              const Divider(),
              Expanded(
                  flex: ratioF,
                  child: ListView.builder(
                    itemCount: value["friends"]!.length,
                    itemBuilder: _buildFriendListTile,
                  )),
            ]);
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Container(height: (MediaQuery.of(context).size.height) * (1 / 15)),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Social:',
                        style: MyTextStyle.get(
                          size: 50,
                          color: WATER_GREEN,
                          bold: true,
                          italic: true,
                        )),
                    TextButton(
                      onPressed: () {
                        _displayAddFriendsDialog(context);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: WATER_GREEN,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: GREY,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color: WHITE,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(child: content)
            ],
          );
        });
  }

  Widget _buildFriendListTile(BuildContext context, index) {
    var friend = DBsnapshot.instance.social.value["friends"]![index];

    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 8),
        child: Text(friend, style: MyTextStyle.get(size: 20)));
  }

  Widget _buildRequestListTile(BuildContext context, index) {
    var request = DBsnapshot.instance.social.value["requests"]![index];

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(request, style: MyTextStyle.get(size: 20)),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
            onPressed: (() {
              FriendsLogic.addFriend(request);
            }),
            icon: const Icon(Icons.done),
            color: GREEN,
            iconSize: 20,
          ),
          IconButton(
            onPressed: (() {
              FriendsLogic.deleteRequest(request);
            }),
            icon: const Icon(Icons.close),
            color: RED,
            iconSize: 20,
          ),
        ])
      ]),
    );
  }

  void _displayAddFriendsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          String result = '';
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Add a Friend:', style: MyTextStyle.get(size: 25)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        result = '';
                        _valueText = value;
                      });
                    },
                    controller: _textFieldController,
                    decoration: const InputDecoration(hintText: "e-mail"),
                  ),
                  Text(result,
                      style:
                          MyTextStyle.get(size: 15, color: _color, bold: true)),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('CANCEL',
                      style: MyTextStyle.get(size: 20, color: RED)),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                TextButton(
                  child: Text('OK',
                      style: MyTextStyle.get(size: 20, color: GREEN)),
                  onPressed: () async {
                    String returned =
                        await FriendsLogic.sendRequest(_valueText);
                    switch (returned) {
                      case 'OK':
                        {
                          setState(() {
                            result = "Friend request sent!";
                            _color = GREEN;
                          });
                          break;
                        }
                      case 'NO':
                        {
                          setState(() {
                            result = "User already added";
                            _color = RED;
                          });
                          break;
                        }
                      case 'NE':
                        {
                          setState(() {
                            result = "User not found";
                            _color = RED;
                          });
                          break;
                        }
                      default:
                        {
                          setState(() {
                            result = "";
                            _color = RED;
                          });
                          break;
                        }
                    }
                  },
                ),
              ],
            );
          });
        });
  }
}
