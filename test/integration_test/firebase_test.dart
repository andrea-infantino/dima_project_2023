import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main(){
  testWidgets('test firebase', (WidgetTester tester) async {
    final firestore = FakeFirebaseFirestore();
    final userData = {
      "achievements": [0, 1, 1, 1],
      "email": "test1@test.test",
      "friends": ["test@test.test"],
      "last_login": "23/8/2024",
      "score": 0,
      "sleep": 0,
      "steps": 0,
      "water": 0
    };
    await firestore.collection('users').add(userData);
    final snapshot = await firestore.collection('users').get();
    expect(snapshot.docs.length, 1);
    expect(snapshot.docs.first.data(), userData);
  });
}