import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';
import 'package:dima_project_2023/main.dart';
import 'package:flutter/services.dart'; // Import this for MethodChannel

class MockFirebase extends Mock implements Firebase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('plugins.flutter.io/firebase_core');

  setUpAll(() async {
    // Mock Firebase initialization
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'Firebase#initializeCore') {
        return {
          'name': 'default',
          'options': {
            'apiKey': 'fakeApiKey',
            'appId': 'fakeAppId',
            'messagingSenderId': 'fakeMessagingSenderId',
            'projectId': 'fakeProjectId',
          },
          'pluginConstants': {},
        };
      } else if (methodCall.method == 'Firebase#otherMethod') {
        // Handle other Firebase method calls if necessary
        return {};
      }
      return null;
    });
  });

  group('Device Type Tests', () {
    test('Phone in portrait mode', () {
      setDeviceType(1080, 1920, 3.0);
      expect(deviceType, 0);
    });

    test('Tablet in portrait mode', () {
      setDeviceType(1600, 2560, 2.0);
      expect(deviceType, 1);
    });

    test('Phone in landscape mode', () {
      setDeviceType(1920, 1080, 3.0);
      expect(deviceType, 0);
    });

    test('Tablet in landscape mode', () {
      setDeviceType(2560, 1600, 2.0);
      expect(deviceType, 1);
    });
  });
}