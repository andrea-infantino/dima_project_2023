import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dima_project_2023/src/widgets/dialog_windows.dart'; // Update this import to match your file structure

void main() {
  testWidgets('OkDialog displays the correct title, content, and closes on OK press', (WidgetTester tester) async {
    // Define the test title and content
    const String testTitle = 'Test Title';
    const String testContent = 'Test Content';

    // Build the dialog within a MaterialApp to provide necessary context
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const OkDialog(title: testTitle, content: testContent);
                    },
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          );
        },
      ),
    ));

    // Tap the button to show the dialog
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle(); // Wait for the dialog to appear

    // Verify that the title and content are correctly displayed
    expect(find.text(testTitle), findsOneWidget);
    expect(find.text(testContent), findsOneWidget);

    // Verify that the OK button is displayed
    expect(find.text('OK'), findsOneWidget);

    // Tap the OK button to close the dialog
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(); // Wait for the dialog to close

    // Verify that the dialog is no longer displayed
    expect(find.byType(AlertDialog), findsNothing);
  });
}
