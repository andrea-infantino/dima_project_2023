import 'dart:async';
import 'package:flutter/foundation.dart';
import 'db_manager.dart';
import 'package:firebase_database/firebase_database.dart';

class DBsnapshot {
  static late DBsnapshot _dbsnapshot;

  ValueNotifier<Map<String, List<String>>> social =
      ValueNotifier({"friends": [], "requests": []});
  ValueNotifier<List<int>> achievements = ValueNotifier([]);
  ValueNotifier<String> last_login = ValueNotifier("");
  ValueNotifier<int> score = ValueNotifier(0);
  ValueNotifier<int> sleep = ValueNotifier(0);
  ValueNotifier<int> steps = ValueNotifier(0);
  ValueNotifier<int> water = ValueNotifier(0);

  ValueNotifier<Map<String, int>> global = ValueNotifier({});

  static void init() {
    _dbsnapshot = DBsnapshot._internal();
  }

  DBsnapshot._internal();

  static DBsnapshot get instance => _dbsnapshot;

  Future<void> listen() async {
    Stream<DatabaseEvent> myStream = myRef.onValue;
    myStream.listen((DatabaseEvent event) {
      dynamic newData = event.snapshot.value;
      bool friendsFound = false,
          requestsFound = false,
          achievementsFound = false;
      for (var key in newData?.keys) {
        if (key == "score") {
          score.value = newData[key];
        } else if (key == "friends") {
          friendsFound = true;
          social.value["friends"] = List.from(newData[key]);
          social.notifyListeners();
        } else if (key == "requests") {
          requestsFound = true;
          social.value["requests"] = List.from(newData[key]);
          social.notifyListeners();
        } else if (key == "achievements") {
          achievementsFound = true;
          achievements.value = List.from(newData[key]);
          achievements.notifyListeners();
        }
      }

      if (!friendsFound) {
        social.value["friends"] = [];
        social.notifyListeners();
      }
      if (!requestsFound) {
        social.value["requests"] = [];
        social.notifyListeners();
      }
      if (!achievementsFound) {
        achievements.value = [];
        achievements.notifyListeners();
      }
    });

    for (var uid in await getUsers()) {
      Stream<DatabaseEvent> stream = usersRef.child("$uid/score").onValue;
      String email = await getEmailOf(uid);
      stream.listen((DatabaseEvent event) {
        dynamic newData = event.snapshot.value;
        global.value[email] = newData;
        global.notifyListeners();
      });
    }
  }
}
