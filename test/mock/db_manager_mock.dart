import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:firebase_database/firebase_database.dart';

// Mock class for Firebase DatabaseReference
class MockDatabaseReference extends Mock implements DatabaseReference {
  @override
  Stream<DatabaseEvent> get onValue => _onValueController.stream;
  
  final _onValueController = StreamController<DatabaseEvent>();

  void addEvent(DatabaseEvent event) {
    _onValueController.add(event);
  }

  void close() {
    _onValueController.close();
  }
}
// Mock class for Firebase DataSnapshot
class MockDataSnapshot extends Mock implements DataSnapshot {
    final data = {
      'score': 100,
      'friends': ['friend1@example.com', 'friend2@example.com'],
      'requests': ['request1@example.com'],
      'achievements': [1, 2, 3],
      'sleep': 8,
      'steps': 10000,
      'water': 2000,
    };
  @override
  get value => data;
}

// Mock class for Firebase DatabaseEvent
class MockDatabaseEvent extends Mock implements DatabaseEvent {
  @override
  get snapshot => MockDataSnapshot();
}


