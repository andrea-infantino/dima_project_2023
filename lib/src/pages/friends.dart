import '../../assets/colors.dart';
import '../db_manager.dart';
import '../session_manager.dart';
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
  void initState() {
    super.initState();
  }

  Future<void> addFriend(String email) async {
    Session.instance.social.value["friends"]!.add(email);
    setFriendsOf(
        Session.instance.uid, Session.instance.social.value["friends"]!);
    deleteRequest(email);

    String myEmail = Session.instance.email;
    List<String> users = List.from(await getUsers());
    for (var uid in users) {
      String currEmail = await getEmailOf(uid);
      if (currEmail.toLowerCase() == email.toLowerCase()) {
        List<String> currFriends = await getFriendsOf(uid);
        currFriends.add(myEmail);
        setFriendsOf(uid, currFriends);
        return;
      }
    }
  }

  Future<String> sendRequest(String email) async {
    String myEmail = Session.instance.email;
    List<String> users = List.from(await getUsers());
    for (var uid in users) {
      String currEmail = await getEmailOf(uid);
      if (currEmail.toLowerCase() == email.toLowerCase()) {
        List<String> requests = List.from(await getRequestsOf(uid));
        if (requests.contains(myEmail.toLowerCase()) ||
            Session.instance.social.value["friends"]!
                .contains(email.toLowerCase()) ||
            email == myEmail ||
            Session.instance.social.value["requests"]!
                .contains(email.toLowerCase())) {
          return 'NO';
        } else {
          requests.add(myEmail);
          setRequestsOf(uid, requests);
          return 'OK';
        }
      }
    }
    return 'NE';
  }

  Future<void> deleteRequest(String email) async {
    Session.instance.social.value["requests"]!.remove(email);
    String uid = Session.instance.uid;
    setRequestsOf(uid, Session.instance.social.value["requests"]!);
  }

  Widget _buildFriendListTile(BuildContext context, index) {
    var friend = Session.instance.social.value["friends"]![index];

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 8),
      child: MyText(
        text: friend,
        size: 20,
      ),
    );
  }

  Widget _buildRequestListTile(BuildContext context, index) {
    var request = Session.instance.social.value["requests"]![index];

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        MyText(
          text: request,
          size: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
            onPressed: (() {
              addFriend(request);
            }),
            icon: const Icon(Icons.done),
            color: GREEN,
            iconSize: 20,
          ),
          IconButton(
            onPressed: (() {
              deleteRequest(request);
            }),
            icon: const Icon(Icons.close),
            color: RED,
            iconSize: 20,
          ),
        ])
      ]),
    );
  }

  void _displayTextInputDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          String result = '';
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const MyText(text: 'Add a Friend:', size: 25),
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
                  MyText(text: result, size: 15, color: _color, bold: true),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const MyText(
                    text: 'CANCEL',
                    size: 20,
                    color: RED,
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                TextButton(
                  child: const MyText(
                    text: 'OK',
                    size: 20,
                    color: GREEN,
                  ),
                  onPressed: () async {
                    String returned = await sendRequest(_valueText);
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

  @override
  Widget build(context) {
    return ValueListenableBuilder<Map<String, List<String>>>(
        valueListenable: Session.instance.social,
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
              ratioF = value["friends"]!.length;
            }
            content = Column(children: [
              const MyText(
                text: 'Requests:',
                size: 20,
                bold: true,
                color: WATER_GREEN,
              ),
              const Divider(),
              Expanded(
                  flex: ratioR,
                  child: ListView.builder(
                    itemCount: value["requests"]!.length,
                    itemBuilder: _buildRequestListTile,
                  )),
              const Divider(),
              MyText(
                text: 'Friends:  [$friendsNumber]',
                size: 20,
                bold: true,
                color: WATER_GREEN,
              ),
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
              Container(height: (Session.instance.deviceHeight) * (1 / 15)),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyText(
                      text: 'Social:',
                      size: 50,
                      color: WATER_GREEN,
                      italic: true,
                      bold: true,
                    ),
                    TextButton(
                      onPressed: () {
                        _displayTextInputDialog(context);
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
}
