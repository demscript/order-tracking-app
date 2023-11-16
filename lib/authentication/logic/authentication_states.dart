import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
class GoogleAuthenticationSuccess extends AuthenticationState {
  final User? user;
  GoogleAuthenticationSuccess(this.user);
}
class GithubAuthenticationSuccess extends AuthenticationState {
  final User? user;
  GithubAuthenticationSuccess(this.user);
}
class AuthenticationError extends AuthenticationState {
  final String error;
  AuthenticationError(this.error);
}
