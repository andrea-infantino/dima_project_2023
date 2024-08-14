import 'dart:async';
import 'db_snapshot.dart';
import 'logic/achievements.dart';
import 'session_manager.dart';
import 'package:firebase_database/firebase_database.dart';

late DatabaseReference myRef, usersRef;
Future<void> initDB() async {
  String uid = Session.instance.uid;
  usersRef = FirebaseDatabase.instance.ref("users/");
  myRef = usersRef.child(uid);

  if ((await myRef.get()).value == null) {
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;
    List<int> achievements = [];
    for (int i = 0; i < Achievements.N; i++) {
      achievements.add(0);
    }
    final data = {
      "email": Session.instance.email,
      "score": 0,
      "last_login": "$day/$month/$year",
      "sleep": 0,
      "steps": 0,
      "water": 0,
      "achievements": achievements
    };
    usersRef.child(Session.instance.uid).set(data);
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

    List<Object?> achievements =
        (await usersRef.child("$uid/achievements").get()).value
            as List<Object?>;
    if (achievements.length < Achievements.N) {
      for (int i = achievements.length; i < Achievements.N; i++) {
        achievements.add(0);
      }
      usersRef.child("$uid/achievements").set(achievements);
    }
  }

  DBsnapshot.init();
  await DBsnapshot.instance.listen();
}

Future<String> getEmailOf(String uid) async {
  var snapshot = await usersRef.child("$uid/email").get();
  return snapshot.value as String;
}

void updateMyScore(score) {
  String uid = Session.instance.uid;
  usersRef.child('$uid/score').set(score);
  usersRef.child('$uid/achievements/0').set(score);
}

Future<int> getScoreOf(String uid) async {
  var snapshot = await usersRef.child("$uid/score").get();
  return snapshot.value as int;
}

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
  usersRef.child("$uid/achievements/1").set(friends.length);
  usersRef.child("$uid/achievements/2").set(friends.length);
  usersRef.child("$uid/achievements/3").set(friends.length);
}

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

Future<List<int>> getAchievements(String uid) async {
  DataSnapshot snapshot = await usersRef.child("$uid/achievements").get();
  List<int> achievements = [];
  List<dynamic>? values = snapshot.value as List<dynamic>?;

  if (values == null) {
    return achievements;
  }

  for (var value in values) {
    achievements.add(value);
  }
  return achievements;
}

Future<List<String>> getUsers() async {
  DataSnapshot dataSnapshot = await usersRef.get();
  List<String> users = [];
  for (var snapshot in dataSnapshot.children) {
    users.add(snapshot.key ?? '');
  }
  return users;
}

Future<void> updateMySteps(steps) async {
  String uid = Session.instance.uid; 
  var snapshot = await usersRef.child("$uid/steps").get();
  int val = snapshot.value as int;
  int oldScore = val ~/ 100;
  int newScore = steps ~/ 100;
  updateMyScore(newScore - oldScore);
  print('uid1: $uid');
  usersRef.child('$uid/steps').set(steps);
}

Future<void> updateMySleep(sleep) async {
  String uid = Session.instance.uid;
  var snapshot = await usersRef.child("$uid/sleep").get();
  int val = snapshot.value as int;
  int oldScore = val.floor();
  int newScore = sleep ~/ 100;
  updateMyScore(newScore - oldScore);
  usersRef.child('$uid/sleep').set(sleep);
}

Future<void> updateMyWater(water) async {
  String uid = Session.instance.uid;
  var snapshot = await usersRef.child("$uid/water").get();
  int val = snapshot.value as int;
  int oldScore = val ~/ 100;
  int newScore = water ~/ 100;
  updateMyScore(newScore - oldScore);
  usersRef.child('$uid/water').set(water);
}