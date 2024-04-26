part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String passwrod;

  AuthSignUp({
    required this.name,
    required this.email,
    required this.passwrod,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String passwrod;

  AuthLogin({
    required this.email,
    required this.passwrod,
  });
}

final class AuthUserLoggedIn extends AuthEvent {}

final class AuthUserSignOut extends AuthEvent {}
