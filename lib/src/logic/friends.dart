import '../db_manager.dart';
import '../db_snapshot.dart';
import '../session_manager.dart';

class FriendsLogic {
  static Future<void> addFriend(String email) async {
    DBsnapshot.instance.social.value["friends"]!.add(email);
    friendsSetFriendsOf(
        Session.instance.uid, DBsnapshot.instance.social.value["friends"]!);
    deleteRequest(email);
    DBsnapshot.instance.social.notifyListeners();
    DBsnapshot.instance.global.notifyListeners();
    String myEmail = Session.instance.email;
    List<String> users = List.from(await friendsGetUsers());
    for (var uid in users) {
      String currEmail = await friendsGetEmailOf(uid);
      if (currEmail.toLowerCase() == email.toLowerCase()) {
        List<String> currFriends = await friendsGetFriendsOf(uid);
        currFriends.add(myEmail);
        friendsSetFriendsOf(uid, currFriends);
        return;
      }
    }
  }

  static Future<String> sendRequest(String email) async {
    String myEmail = Session.instance.email;
    List<String> users = List.from(await friendsGetUsers());
    for (var uid in users) {
      String currEmail = await friendsGetEmailOf(uid);
      if (currEmail.toLowerCase() == email.toLowerCase()) {
        List<String> requests = List.from(await friendsGetRequestsOf(uid));
        if (requests.contains(myEmail.toLowerCase()) ||
            DBsnapshot.instance.social.value["friends"]!
                .contains(email.toLowerCase()) ||
            email == myEmail ||
            DBsnapshot.instance.social.value["requests"]!
                .contains(email.toLowerCase())) {
          return 'NO';
        } else {
          requests.add(myEmail);
          friendsSetRequestOf(uid, requests);
          return 'OK';
        }
      }
    }
    return 'NE';
  }
  
  static Future<void> deleteRequest(String email) async {
    DBsnapshot.instance.social.value["requests"]!.remove(email);
    String uid = Session.instance.uid;
    friendsSetRequestOf(uid, DBsnapshot.instance.social.value["requests"]!);
  }

  static Future<List<String>> friendsGetUsers() async {
    return await getUsers();
  }

  static Future<List<String>> friendsGetRequestsOf(String uid) async {
    return await getRequestsOf(uid);
  }

  static Future<String> friendsGetEmailOf(String uid) async {
    return await getEmailOf(uid);
  }

  static void friendsSetRequestOf(String uid, List<String> requests) async {
    setRequestsOf(uid, requests);
  }

  static Future<List<String>> friendsGetFriendsOf(String uid) async {
    return await getFriendsOf(uid);
  }

  static void friendsSetFriendsOf(String uid, List<String> friends) async {
    setFriendsOf(uid, friends);
  }
  
}
