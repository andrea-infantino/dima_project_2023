import 'package:dima_project_2023/src/db_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dima_project_2023/src/db_snapshot.dart';

// Import mocks
import '../mock/db_manager_mock.dart';

void main() {
  setUp(() {
    // Initialize the DBsnapshot instance
    DBsnapshot.init();
  });

  test('DBsnapshot initializes with default values', () {
    final dbsnapshot = DBsnapshot.instance;

    expect(dbsnapshot.social.value, equals({"friends": [], "requests": []}));
    expect(dbsnapshot.achievements.value, equals([]));
    expect(dbsnapshot.last_login.value, equals(""));
    expect(dbsnapshot.score.value, equals(0));
    expect(dbsnapshot.sleep.value, equals(0));
    expect(dbsnapshot.steps.value, equals(0));
    expect(dbsnapshot.water.value, equals(0));
    expect(dbsnapshot.global.value, equals({}));
  });

}
