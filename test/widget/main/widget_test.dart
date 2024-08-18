import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:dima_project_2023/main.dart';
import 'package:dima_project_2023/src/pages/authentication/login.dart';

void main() {
  setUp(() {
    // Initialize deviceType before each test
    deviceType = 0; // Default initialization, you can change this as needed
  });

  group('Main Widget Tests', () {
    testWidgets('should set deviceType correctly for phone', (WidgetTester tester) async {
      // Mock device dimensions for phone
      tester.view.physicalSize = Size(1080, 1920);
      tester.view.devicePixelRatio = 2.0;

      setDeviceType(1080, 1920, 2.0);

      await tester.pumpWidget(const App());

      expect(deviceType, 0);
    });

    testWidgets('should set deviceType correctly for tablet', (WidgetTester tester) async {
      // Mock device dimensions for tablet
      tester.view.physicalSize = Size(2048, 1536);
      tester.view.devicePixelRatio = 2.0;

      setDeviceType(2048, 1536, 2.0);

      await tester.pumpWidget(const App());

      expect(deviceType, 1);
    });

    testWidgets('App widget should build correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}