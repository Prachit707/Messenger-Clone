import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messenger_clone/helperfunctions/sharedpref_helper.dart';
import 'package:messenger_clone/services/database.dart';
import 'package:messenger_clone/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        try {
          final UserCredential result =
              await _firebaseAuth.signInWithCredential(credential);
          final User? userDetails = result.user;

          if (userDetails != null) {
            SharedPreferenceHelper().saveUserEmail(userDetails.email ?? "");
            SharedPreferenceHelper().saveUserId(userDetails.uid ?? "");
            SharedPreferenceHelper().saveUserName(
                userDetails?.email?.replaceAll("@gmail.com", "") ?? "");
            SharedPreferenceHelper()
                .saveDisplayName(userDetails.displayName ?? "");
            SharedPreferenceHelper()
                .saveUserProfileUrl(userDetails.photoURL ?? "");

            Map<String, dynamic> userInfoMap = {
              "email": userDetails.email,
              "username": userDetails.email!.replaceAll("@gmail.com", ""),
              "name": userDetails.displayName,
              "imgUrl": userDetails.photoURL
            };

            await DatabaseMethods().addUserInfoToDB(
                userDetails.uid!, userInfoMap); // Fixed this line
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          } else {
            print('User details are null');
          }
        } catch (e) {
          print('Error signing in with credential: $e');
        }
      } else {
        print('Google sign-in account is null');
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Future<void> signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await auth.signOut();
    // Navigate to the sign-in screen or perform any other required action
  }
}
