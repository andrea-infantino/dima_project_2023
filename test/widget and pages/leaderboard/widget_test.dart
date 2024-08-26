import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dima_project_2023/src/session_manager.dart';
import 'package:dima_project_2023/src/pages/leaderboard.dart';
import 'package:dima_project_2023/src/db_snapshot.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../mock.dart';
void main() {
  setupFirebaseAuthMocks();
  group('LeaderboardPage Widget Tests', () {
    setUp(() async {
      await Firebase.initializeApp();
      
      final instance = FakeFirebaseFirestore();

      await instance.collection("users").add({
        'email': 'user1@example.com',
      });
      DBsnapshot.init();
      Session.init();
      Session.instance.setUser("user1@example.com", "bob");
      // Initialize mock data for testing
      DBsnapshot.instance.global.value = {
        'user1@example.com': 100,
        'user2@example.com': 90,
        'user3@example.com': 80,
      };

      DBsnapshot.instance.social.value = {
        'friends': ['user2@example.com']
      };
    });

    testWidgets('LeaderboardPage displays correctly with initial data',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LeaderboardPage(),
          ),
        ),
      );

      // Check if the leaderboard title is displayed
      expect(find.text('Leaderboard:'), findsOneWidget);

      // Check if the tabs are displayed
      expect(find.text('Global'), findsOneWidget);
      expect(find.text('Local'), findsOneWidget);
    });
  });
}