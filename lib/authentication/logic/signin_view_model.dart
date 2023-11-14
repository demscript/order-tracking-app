import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/authentication/data/repository/authentication_service.dart';
import 'package:order_tracking/authentication/logic/authentication_states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/repository/authentication_service_strings.dart';

class SignInViewModel extends StateNotifier<AuthenticationState> {
  final Ref ref;
  SignInViewModel(this.ref) : super(AuthenticationInitial());

  Future googleSignIn() async {
    state = AuthenticationLoading();
    try {
      final response =
          await ref.read(authenticationServiceProvider).googleSignIn();
      state = GoogleAuthenticationSuccess(response);
      return response;
    } catch (e) {
      state = AuthenticationError(e.toString());
    }
  }

  Future githubSignIn() async {
    state = AuthenticationLoading();
    try {
      const String url =
          "https://github.com/login/oauth/authorize?client_id=${AuthenticationServiceString.clientGithubId}&scope=user:email";
      final uri = Uri.parse(url);
      await launchUrl(uri);
      final String code = uri.queryParameters['code'] ?? '';
      //final response =
      //   await ref.read(authenticationServiceProvider).githubSignIn();
      state = GithubAuthenticationSuccess(code);
      return code;
    } catch (e) {
      state = AuthenticationError(e.toString());
    }
  }
}

final signInVM =
    StateNotifierProvider.autoDispose((ref) => SignInViewModel(ref));
