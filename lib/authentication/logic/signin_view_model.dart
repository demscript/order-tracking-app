import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/authentication/data/repository/authentication_service.dart';
import 'package:order_tracking/authentication/logic/authentication_states.dart';

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

  Future githubSignIn(BuildContext context) async {
    state = AuthenticationLoading();
    try {
      final response =
        await ref.read(authenticationServiceProvider).githubSignIn(context);
      state = GithubAuthenticationSuccess(response);
      return response;
    } catch (e) {
      state = AuthenticationError(e.toString());
    }
  }
}

final signInVM =
    StateNotifierProvider.autoDispose((ref) => SignInViewModel(ref));
