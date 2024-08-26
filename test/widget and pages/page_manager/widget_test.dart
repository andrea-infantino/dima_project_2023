import 'package:dima_project_2023/main.dart';
import 'package:dima_project_2023/src/db_snapshot.dart';
import 'package:dima_project_2023/src/session_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dima_project_2023/src/pages/achievements.dart';
import 'package:dima_project_2023/src/pages/friends.dart';
import 'package:dima_project_2023/src/pages/home.dart';
import 'package:dima_project_2023/src/pages/leaderboard.dart';
import 'package:dima_project_2023/assets/colors.dart';
import 'package:dima_project_2023/src/pages/pages_manager.dart';

import '../mock.dart';

// Create mocks for dependent classes if needed
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setupFirebaseAuthMocks();

  group('PagesManager Widget Tests', () {
    // Define test variables
    late NavigatorObserver mockObserver;

    setUp(() async {
      // Initialize mocks before each test
      await Firebase.initializeApp();
      mockObserver = MockNavigatorObserver();
      deviceType = 0;
      DBsnapshot.init();
      Session.init();
    });

    testWidgets('displays loading indicator initially', (WidgetTester tester) async {
      // Build the PagesManager widget
      await tester.pumpWidget(
        MaterialApp(
          home: const PagesManager(),
          navigatorObservers: [mockObserver],
        ),
      );

      // Check if loading indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Simulate waiting for loading to finish
      await tester.pump(const Duration(seconds: 2));

      // Check if loading indicator is removed
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('navigates between pages correctly', (WidgetTester tester) async {
      // Build the PagesManager widget
      await tester.pumpWidget(
        MaterialApp(
          home: const PagesManager(),
          navigatorObservers: [mockObserver],
        ),
      );

      // Simulate waiting for loading to finish
      await tester.pump(const Duration(seconds: 2));

      // Verify initial page is HomePage
      expect(find.byType(HomePage), findsOneWidget);

      // Tap on the "Friends" navigation item
      await tester.tap(find.byIcon(Icons.people_outline));
      await tester.pumpAndSettle();

      // Verify that it navigated to FriendsPage
      expect(find.byType(FriendsPage), findsOneWidget);

      // Tap on the "Leaderboard" navigation item
      await tester.tap(find.byIcon(Icons.leaderboard_outlined));
      await tester.pumpAndSettle();

      // Verify that it navigated to LeaderboardPage
      expect(find.byType(LeaderboardPage), findsOneWidget);

      // Tap on the "Achievements" navigation item
      await tester.tap(find.byIcon(Icons.emoji_events_outlined));
      await tester.pumpAndSettle();

      // Verify that it navigated to AchievementsPage
      expect(find.byType(AchievementsPage), findsOneWidget);
    });
  });
}
