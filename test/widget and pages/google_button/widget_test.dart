import 'package:dima_project_2023/src/logic/authentication/link_google.dart';
import 'package:dima_project_2023/src/widgets/DynamicButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../mock.dart'; // from: https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_auth/firebase_auth/test/mock.dart



void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  group('MyDynamicButton Widget Test', () {
    testWidgets('renders MyDynamicButton correctly', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyDynamicButton(),
          ),
        ),
      );

      // Verify the widget is created without errors
      expect(find.byType(MyDynamicButton), findsOneWidget);

      // Verify the button's text is correct based on isConnected() initial state
      if (isConnected()) {
        expect(find.text('Unlink Google'), findsOneWidget);
      } else {
        expect(find.text('Link Google'), findsOneWidget);
      }
    });
  });
}