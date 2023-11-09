import 'dart:async';
import 'session_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

late DatabaseReference myRef, usersRef;

Future<void> loadDB() async {
  String uid = Session.instance.uid;
  usersRef = FirebaseDatabase.instance.ref("users/");
  myRef = usersRef.child(uid);

  if ((await myRef.get()).value == null) {
    initializeDBData();
  } else {
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;
    String now = "$day/$month/$year";
    String lastLogin =
        (await usersRef.child("$uid/last_login").get()).value as String;
    if (lastLogin != now) {
      usersRef.child("$uid/last_login").set(now);
      updateMySleep(0);
      updateMySteps(0);
      updateMyWater(0);
    }
  }

  Stream<DatabaseEvent> myStream = myRef.onValue;
  myStream.listen((DatabaseEvent event) {
    dynamic newData = event.snapshot.value;
    bool friendsFound = false, requestsFound = false;
    for (var key in newData?.keys) {
      if (key == "score") {
        Session.instance.score.value = newData[key];
      } else if (key == "friends") {
        friendsFound = true;
        Session.instance.social.value["friends"] = List.from(newData[key]);
        Session.instance.social.notifyListeners();
      } else if (key == "requests") {
        requestsFound = true;
        Session.instance.social.value["requests"] = List.from(newData[key]);
        Session.instance.social.notifyListeners();
      }
    }

    if (!friendsFound) {
      Session.instance.social.value["friends"] = [];
      Session.instance.social.notifyListeners();
    }
    if (!requestsFound) {
      Session.instance.social.value["requests"] = [];
      Session.instance.social.notifyListeners();
    }
  });
}

void initializeDBData() {
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  final data = {
    "email": Session.instance.email,
    "score": 0,
    "last_login": "$day/$month/$year",
    "sleep": 0,
    "steps": 0,
    "water": 0
  };
  usersRef.child(Session.instance.uid).set(data);
}

Future<String> getEmailOf(String uid) async {
  var snapshot = await usersRef.child("$uid/email").get();
  return snapshot.value as String;
}

/*Future<int> getMyScore() async {
  return await getScoreOf(Session.instance.uid);
}*/

void updateMyScore(score) {
  String uid = Session.instance.uid;
  usersRef.child('$uid/score').set(score);
}

Future<int> getScoreOf(String uid) async {
  var snapshot = await usersRef.child("$uid/score").get();
  return snapshot.value as int;
}

/*Future<List<String>> getMyFriends() async {
  return await getFriendsOf(Session.instance.uid);
}*/

Future<List<String>> getFriendsOf(String uid) async {
  DataSnapshot snapshot = await usersRef.child("$uid/friends").get();
  List<String> myFriends = [];
  List<dynamic>? values = snapshot.value as List<dynamic>?;

  if (values == null) {
    return myFriends;
  }

  for (var value in values) {
    myFriends.add(value);
  }
  return myFriends;
}

void setFriendsOf(String uid, List<String> friends) async {
  usersRef.child("$uid/friends").set(friends);
}

/*Future<List<String>> getMyRequests() async {
  return getRequestsOf(Session.instance.uid);
}*/

Future<List<String>> getRequestsOf(String uid) async {
  DataSnapshot snapshot = await usersRef.child("$uid/requests").get();
  List<String> myRequests = [];
  List<dynamic>? values = snapshot.value as List<dynamic>?;

  if (values == null) {
    return myRequests;
  }

  for (var value in values) {
    myRequests.add(value);
  }

  return myRequests;
}

void setRequestsOf(String uid, List<String> requests) async {
  usersRef.child("$uid/requests").set(requests);
}

Future<List<String>> getUsers() async {
  DataSnapshot dataSnapshot = await usersRef.get();
  List<String> users = [];
  for (var snapshot in dataSnapshot.children) {
    users.add(snapshot.key ?? '');
  }
  return users;
}

/*Future<int> getMySteps() async {
  String uid = Session.instance.uid;
  var snapshot = await usersRef.child("$uid/steps").get();
  return snapshot.value as int;
}*/

void updateMySteps(steps) {
  String uid = Session.instance.uid;
  usersRef.child('$uid/steps').set(steps);
}

/*Future<int> getMySleep() async {
  String uid = Session.instance.uid;
  var snapshot = await usersRef.child("$uid/sleep").get();
  return snapshot.value as int;
}*/

void updateMySleep(sleep) {
  String uid = Session.instance.uid;
  usersRef.child('$uid/sleep').set(sleep);
}

/*Future<int> getMyWater() async {
  String uid = Session.instance.uid;
  var snapshot = await usersRef.child("$uid/water").get();
  return snapshot.value as int;
}*/

void updateMyWater(water) {
  String uid = Session.instance.uid;
  usersRef.child('$uid/water').set(water);
}
