import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:dima_project_2023/src/db_snapshot.dart';
import 'package:dima_project_2023/src/logic/achievements.dart';
import 'package:dima_project_2023/src/pages/achievements.dart';
import 'package:flutter/foundation.dart'; // Import for ValueNotifier

// Mock class for DBsnapshot
class MockDBsnapshot extends Mock implements DBsnapshot {}

void main() {
  late MockDBsnapshot mockDBsnapshot;

  setUp(() {
    mockDBsnapshot = MockDBsnapshot();
    DBsnapshot.instance = mockDBsnapshot;

    // Mocking the values returned by DBsnapshot
    DBsnapshot.init();
    DBsnapshot.instance.score.value = 500;
    DBsnapshot.instance.social.value["friends"] = ['friend1', 'friend2'];
    DBsnapshot.instance.achievements.value = [1, 2, 3, 4];
    Achievements.init();

    // Initialize DBsnapshot and Achievements
    DBsnapshot.init();
    Achievements.init();
  });

  testWidgets('AchievementsPage displays correctly', (WidgetTester tester) async {
    // Build the AchievementsPage widget
    await tester.pumpWidget(MaterialApp(
      home: AchievementsPage(),
    ));

    // Verify the title is displayed
    expect(find.text('Achievements:'), findsOneWidget);

    // Verify the list of achievements is displayed
    expect(find.byType(ListView), findsOneWidget);

  });
}