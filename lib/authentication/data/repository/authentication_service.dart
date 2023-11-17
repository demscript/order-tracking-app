import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:order_tracking/authentication/data/repository/authentication_service_strings.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn? _googleSignIn;

  Future<User?> googleSignIn() async {
    try {
      if (Platform.isIOS) {
        _googleSignIn = GoogleSignIn(
            clientId: AuthenticationServiceString.clientOAuthIOSId);
      } else {
        _googleSignIn =
            GoogleSignIn(serverClientId: AuthenticationServiceString.clientOAuthId);
      }
      UserCredential userCredential;
      final GoogleSignInAccount? googleUser = await _googleSignIn?.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
      final user = userCredential.user;
      return user;
    } catch (e, s) {
      print(e);
      throw "An error occurred";
    }
  }

  Future<User?> githubSignIn(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: AuthenticationServiceString.clientGithubId,
      clientSecret: AuthenticationServiceString.clientGithubSecret,
      redirectUrl:
          "https://order-tracking-d95df.firebaseapp.com/__/auth/handler",
    );
    try {
      UserCredential userCredential;
      var result = await gitHubSignIn.signIn(context);
      if (result.status == GitHubSignInResultStatus.ok) {
        userCredential = await _auth.signInWithCredential(
            GithubAuthProvider.credential(result.token ?? ""));
      } else if (result.status == GitHubSignInResultStatus.cancelled) {
        throw "Please try again later";
      } else {
        throw "An error occurred";
      }
      return userCredential.user;
    } catch (e) {
      print(e);
      throw "An error occurred";
    }
  }

  void signOutGoogle() async {
    if (Platform.isIOS) {
      _googleSignIn = GoogleSignIn(
          clientId: AuthenticationServiceString.clientOAuthIOSId);
    } else {
      _googleSignIn =
          GoogleSignIn(serverClientId: AuthenticationServiceString.clientOAuthId);
    }
    await _googleSignIn?.signOut();
    await _auth.signOut();
  }
}

final authenticationServiceProvider =
    Provider((ref) => AuthenticationService());
