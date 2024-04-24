import 'dart:async';

import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp userSignUp;
  AuthBloc({
    required this.userSignUp,
  }) : super(AuthInitial()) {
    on<AuthSignUp>(_signUp);
  }

  Future<void> _signUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await userSignUp.call(
      UserSignUpParams(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );
    res.fold(
      (failure) => emit(
        AuthFailure(failure.message),
      ),
      (uid) => emit(
        AuthSuccess(uid),
      ),
    );
  }
}
