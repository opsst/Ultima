import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ultima/views/login-view.dart';
import 'package:ultima/views/navigation-view.dart';
import 'package:ultima/views/welcome-view.dart';

class AuthService {

  signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]
    ).signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Navigator.pop(context);
    Get.back();
    try {
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print('Error Firebase google authentication exceptions');
      print(e.message);
    } catch (e) {
      print('Error google manage other exceptions');
      print(e);
    }

  }

  signInWithFacebook(BuildContext context) async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      final AccessToken accessToken = loginResult.accessToken!;
      final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
      Navigator.pop(context);
      try {
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        print('Error Firebase authentication exceptions');
        print(e.message);
      } catch (e) {
        print('Error manage other exceptions');
        print(e);
      }
    } else {
      print('Login facebook unsuccessful');
    }
  }

  handleAuthState(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        // FlutterSecureStorage storage = FlutterSecureStorage();/
        // String? mytoken = await storage.read(key: "token");
        if(snapshot.hasData) {
          return NavigationBarView();
        } else {
          return WelcomepageView();
        }
      }
    );
  }

  Future logout() async{
    FirebaseAuth.instance.signOut();
  }

}