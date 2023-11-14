import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:order_tracking/authentication/data/repository/authentication_service_strings.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(clientId: AuthenticationServiceString.clientOAuthId);

  Future<User?> googleSignIn() async {
    try {
      UserCredential userCredential;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
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
      rethrow;
    }
  }

  Future<String> githubSignIn() async {
    try {
      const String url = "https://github.com/login/oauth/authorize?client_id=${AuthenticationServiceString.clientGithubId}&scope=user:email";
      final uri = Uri.parse(url);
      await launchUrl(uri);
      final String code = uri.queryParameters['code'] ?? '';
      return code;
    } catch (e, s) {
      print(e);
      throw e;
    }
  }

  void signOutGoogle() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}

final authenticationServiceProvider =
    Provider((ref) => AuthenticationService());



