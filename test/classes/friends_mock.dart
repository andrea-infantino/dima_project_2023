import 'package:mockito/mockito.dart';

// Mock class for FriendsLogic
class MockFriendsLogic extends Mock {
  Future<List<String>> friendsGetUsers() {
    return super.noSuchMethod(
      Invocation.method(#friendsGetUsers, []),
      returnValue: Future.value([]),
      returnValueForMissingStub: Future.value([]),
    );
  }

  Future<String> friendsGetEmailOf(String uid) {
    return super.noSuchMethod(
      Invocation.method(#friendsGetEmailOf, [uid]),
      returnValue: Future.value(''),
      returnValueForMissingStub: Future.value(''),
    );
  }
  
  Future<List<String>> friendsGetRequestsOf(String uid) {
    return super.noSuchMethod(
      Invocation.method(#friendsGetRequestsOf, [uid]),
      returnValue: Future.value([]),
      returnValueForMissingStub: Future.value([]),
    );
  }
  
  Future<List<String>> friendsGetFriendsOf(String uid) {
    return super.noSuchMethod(
      Invocation.method(#friendsGetFriendsOf, [uid]),
      returnValue: Future.value([]),
      returnValueForMissingStub: Future.value([]),
    );
  }
  
  void friendsSetRequestOf(String uid, List<String> requests) {
    super.noSuchMethod(
      Invocation.method(#friendsSetRequestOf, [uid, requests]),
      returnValueForMissingStub: null,
    );
  }

  void friendsSetFriendsOf(String uid, List<String> friends) {
    super.noSuchMethod(
      Invocation.method(#friendsSetFriendsOf, [uid, friends]),
      returnValueForMissingStub: null,
    );
  }
  
}
class MockFriendsSetRequestOf extends Mock {
  void call(String uid, List<String> requests);
}
void friendsSetRequestOf(String uid, List<String> requests) async {
  // This will be replaced by the mock in the test
}