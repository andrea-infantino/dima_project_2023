import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

linkEmailGoogle() async
  { 
    //get currently logged in user
    User existingUser = FirebaseAuth.instance.currentUser!;
    for (UserInfo userInfo in existingUser.providerData) {
      if (userInfo.providerId == 'google.com') {
        print('User is already linked with a Google account.');
        return;
      }
    }
    //get the credentials of the new linking account
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser!=null){ 
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential gcredential = GoogleAuthProvider.credential(
                                          accessToken: googleAuth.accessToken,
                                          idToken: googleAuth.idToken,
                                          );

      return await existingUser.linkWithCredential(gcredential);
    }
    else{
      print("Google Sign in Failed");
    }
  }
unlinkGoogle() async
  {
    //get currently logged in user
    User existingUser = FirebaseAuth.instance.currentUser!;
    //unlink the account
    await existingUser.unlink("google.com");
    GoogleSignIn().signOut();
  }
bool isConnected()
  {
    if (FirebaseAuth.instance.currentUser == null) {
      print('No user is currently signed in.');
      return false;
    }
    User existingUser = FirebaseAuth.instance.currentUser!;
    for (UserInfo userInfo in existingUser.providerData) {
      if (userInfo.providerId == 'google.com') {
        print('User is already linked with a Google account.');
        return true;
      }
    }
    return false;
  }