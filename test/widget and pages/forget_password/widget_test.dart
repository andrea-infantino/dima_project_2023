import 'package:dima_project_2023/main.dart';
import 'package:dima_project_2023/src/db_snapshot.dart';
import 'package:dima_project_2023/src/pages/authentication/forgot_password.dart';
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
  testWidgets('ForgotPasswordPage basic rendering test', (WidgetTester tester) async {
    // Build the ForgotPasswordPage widget
    await tester.pumpWidget(
      MaterialApp(
        home: ForgotPasswordPage(),
      ),
    );

    // Verify ForgotPasswordPage is rendered
    expect(find.byType(ForgotPasswordPage), findsOneWidget);

    // Check for the presence of the email text field
    expect(find.byType(TextField), findsOneWidget);

    // Check for the presence of the 'Send Reset Link' button
    expect(find.text('Send Reset Link'), findsOneWidget);

    // Check if the logo image is present
    expect(find.byType(Image), findsOneWidget);

    // Interact with the TextField by entering an email
    await tester.enterText(find.byType(TextField), 'test@example.com');
    expect(find.text('test@example.com'), findsOneWidget);

    // Tap on the 'Send Reset Link' button
    await tester.tap(find.text('Send Reset Link'));
    await tester.pump(); // Rebuild after the button press

    // Verify no error message is shown (as Firebase is not mocked here)
    expect(find.textContaining('Password reset email sent'), findsNothing);
    expect(find.byType(SnackBar), findsNothing); // Snackbar won't show without Firebase mock
  });
}