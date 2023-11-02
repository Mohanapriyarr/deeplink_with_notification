// function to implement the google signin

// creating firebase instance
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common_views/show_toast.dart';
import 'log/log.dart';

// final FirebaseAuth auth = FirebaseAuth.instance;
class Google {
  Future<GoogleSignInAccount?> signup() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Getting auth credential
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      try {
        // Getting users credential
        UserCredential userCredential =
            await auth.signInWithCredential(authCredential);
        // user = userCredential;
        Log.info(info: 'google signin ~ user ~ $googleSignInAccount');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          showToast(
              message:
                  'The account already exists with a different credential');
        } else if (e.code == 'invalid-credential') {
          showToast(
              message:
                  'Error occurred while accessing credentials. Try again.');
        }
      } catch (e) {
        showToast(
            message: 'Error occurred while accessing credentials. Try again.');
      }
    }
    return googleSignInAccount;
  }

  Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      showToast(message: 'Error signing out. Try again.');
    }
  }

  Future<GoogleSignInAccount?> googleLogIn() async {
    //? first sign out if already signed in ///////////////
    final isSignedIn =
        await GoogleSignIn(scopes: ['profile', 'email']).isSignedIn();
    if (isSignedIn) {
      await GoogleSignIn().disconnect();
      FirebaseAuth.instance.signOut();
    }
    //? ////////////////////////////////////////////////

    final _googleUser = await signup();
    return _googleUser;
  }
}
