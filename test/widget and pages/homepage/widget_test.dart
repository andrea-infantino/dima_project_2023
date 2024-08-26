import 'package:dima_project_2023/src/db_snapshot.dart';
import 'package:dima_project_2023/src/logic/authentication/link_google.dart';
import 'package:dima_project_2023/src/pages/home.dart';
import 'package:dima_project_2023/src/session_manager.dart';
import 'package:dima_project_2023/src/widgets/DynamicButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../mock.dart'; // from: https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_auth/firebase_auth/test/mock.dart



void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    DBsnapshot.init();
    Session.init();
    await Firebase.initializeApp();
  });

  testWidgets('HomePage basic rendering test', (WidgetTester tester) async {
    // Build the HomePage widget
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );

    // Verify HomePage is rendered
    expect(find.byType(HomePage), findsOneWidget);

    // Check for the user's greeting text with "Hi" (as actual username handling is mocked/stubbed in real tests)
    expect(find.textContaining('Hi'), findsOneWidget);

    // Verify the logout button is present with the text 'Log-out'
    expect(find.text('Log-out'), findsOneWidget);

    // Check that the dynamic button is rendered
    expect(find.byType(MyDynamicButton), findsOneWidget);

    // Check that activity titles are present (Steps, Hydration, Sleep)
    expect(find.text('Steps'), findsOneWidget);
    expect(find.text('Hydratation'), findsOneWidget);
    expect(find.text('Sleep'), findsOneWidget);
  });
}