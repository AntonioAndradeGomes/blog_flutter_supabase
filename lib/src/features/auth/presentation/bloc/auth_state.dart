part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;

  AuthSuccess(
    this.user,
  );
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(
    this.message,
  );
}
