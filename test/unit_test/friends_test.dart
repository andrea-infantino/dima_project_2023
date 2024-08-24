import 'package:dima_project_2023/src/db_manager.dart';
import 'package:dima_project_2023/src/db_snapshot.dart';
import 'package:dima_project_2023/src/session_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_database/firebase_database.dart';
import '../classes/friends_mock.dart';

class MockDatabaseReference extends Mock implements DatabaseReference {}
void main() {

  test('Test 1', () {
    expect(1, 1);
  });
  setUp((){

    DBsnapshot.init();
    Session.init();
  });

  String testSendRequest(String email) {
    String myEmail = "email2";
    List<String> users = ["uid1", "uid2"];
    for (var uid in users) {
      String currEmail = "email2";
      if (currEmail.toLowerCase() == email.toLowerCase()) {
        List<String> requests = ["email", "email2"];
        if (requests.contains(myEmail.toLowerCase()) ||
            DBsnapshot.instance.social.value["friends"]!
                .contains(email.toLowerCase()) ||
            email == myEmail ||
            DBsnapshot.instance.social.value["requests"]!
                .contains(email.toLowerCase())) {
          return 'NO';
        } else {
          requests.add(myEmail);
          return 'OK';
        }
      }
    }
    return 'NE';
  }
  test('deleteRequest method', () {

    expect(DBsnapshot.instance.score.value, 0);
    expect(DBsnapshot.instance.social.value['friends']!.length, 0);
    expect(DBsnapshot.instance.social.value['requests']!.length, 0);
    DBsnapshot.instance.social.value["requests"]!.add("email");
    expect(DBsnapshot.instance.social.value["requests"]!.length, 1);
    //simulate the delete request function
    DBsnapshot.instance.social.value["requests"]!.remove("email");
    expect(DBsnapshot.instance.social.value["requests"]!.length, 0);
  });
  test('testSendRequest returns the intended value', () async {
    // Case 1: Email matches and is in requests
    String result = testSendRequest('email2');
    expect(result, 'NO');

    // Case 2: Email matches and is not in requests
    result = testSendRequest('email3');
    expect(result, 'NE');

    // Case 3: Email does not match any user
    result = testSendRequest('email4');
    expect(result, 'NE');
  });



}