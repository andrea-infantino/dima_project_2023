import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

linkEmailGoogle() async
  { 
    //get currently logged in user
    User existingUser = FirebaseAuth.instance.currentUser!;
   
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
  }
  
