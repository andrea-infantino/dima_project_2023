import '../db_manager.dart';
import '../db_snapshot.dart';
import '../session_manager.dart';

class FriendsLogic {
  static Future<void> addFriend(String email) async {
    DBsnapshot.instance.social.value["friends"]!.add(email);
    setFriendsOf(
        Session.instance.uid, DBsnapshot.instance.social.value["friends"]!);
    deleteRequest(email);

    String myEmail = Session.instance.email;
    List<String> users = List.from(await getUsers());
    for (var uid in users) {
      String currEmail = await getEmailOf(uid);
      if (currEmail.toLowerCase() == email.toLowerCase()) {
        List<String> currFriends = await getFriendsOf(uid);
        currFriends.add(myEmail);
        setFriendsOf(uid, currFriends);
        return;
      }
    }
  }

  static Future<String> sendRequest(String email) async {
    String myEmail = Session.instance.email;
    List<String> users = List.from(await getUsers());
    for (var uid in users) {
      String currEmail = await getEmailOf(uid);
      if (currEmail.toLowerCase() == email.toLowerCase()) {
        List<String> requests = List.from(await getRequestsOf(uid));
        if (requests.contains(myEmail.toLowerCase()) ||
            DBsnapshot.instance.social.value["friends"]!
                .contains(email.toLowerCase()) ||
            email == myEmail ||
            DBsnapshot.instance.social.value["requests"]!
                .contains(email.toLowerCase())) {
          return 'NO';
        } else {
          requests.add(myEmail);
          setRequestsOf(uid, requests);
          return 'OK';
        }
      }
    }
    return 'NE';
  }

  static Future<void> deleteRequest(String email) async {
    DBsnapshot.instance.social.value["requests"]!.remove(email);
    String uid = Session.instance.uid;
    setRequestsOf(uid, DBsnapshot.instance.social.value["requests"]!);
  }
}
