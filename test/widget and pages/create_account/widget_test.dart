import 'package:dima_project_2023/main.dart';
import 'package:dima_project_2023/src/db_snapshot.dart';
import 'package:dima_project_2023/src/pages/authentication/create_account.dart';
import 'package:dima_project_2023/src/session_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    DBsnapshot.init();
    Session.init();
    await Firebase.initializeApp();
    deviceType = 1;
  });
  testWidgets('RegistrationPage basic rendering test', (WidgetTester tester) async {
    // Build the RegistrationPage widget
    await tester.pumpWidget(
      MaterialApp(
        home: RegistrationPage(),
      ),
    );

    // Verify RegistrationPage is rendered
    expect(find.byType(RegistrationPage), findsOneWidget);

    // Check for the presence of the email text field
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);

    // Check for the presence of the password text field
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

    // Check for the presence of the confirm password text field
    expect(find.widgetWithText(TextField, 'Confirm Password'), findsOneWidget);

    // Check for the presence of the 'Register' button
    expect(find.text('Register'), findsOneWidget);

    // Check for the presence of the 'Already have an account?' button
    expect(find.text('Already have an account? Click here to log-in'), findsOneWidget);

    // Check if the logo image is present
    expect(find.byType(Image), findsOneWidget);

    // Interact with the TextFields by entering text
    await tester.enterText(find.widgetWithText(TextField, 'Email'), 'test@example.com');
    expect(find.text('test@example.com'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'Password'), 'password123');
    expect(find.text('password123'), findsAtLeast(1));

    await tester.enterText(find.widgetWithText(TextField, 'Confirm Password'), 'password123');
    expect(find.text('password123'), findsAtLeast(1));

    // Tap on the 'Register' button
    await tester.tap(find.text('Register'));
    await tester.pump(); // Rebuild after the button press

    // Check if CircularProgressIndicator shows up when _isLoading is true
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}