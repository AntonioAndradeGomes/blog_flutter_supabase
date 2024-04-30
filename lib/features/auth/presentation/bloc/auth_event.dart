part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUp({
    required this.email,
    required this.password,
    required this.name,
  });
}

class AuthAuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthAuthLogin({
    required this.email,
    required this.password,
  });
}
