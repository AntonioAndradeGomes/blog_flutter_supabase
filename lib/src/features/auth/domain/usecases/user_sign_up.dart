import 'package:blog_app/src/core/error/failure.dart';
import 'package:blog_app/src/core/usecases/usecase.dart';
import 'package:blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<UserEntity, UserSignUpParams> {
  final AuthRepository repository;

  UserSignUp(
    this.repository,
  );

  @override
  Future<Either<Failure, UserEntity>> call(
    UserSignUpParams params,
  ) async {
    return await repository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String name;
  final String password;

  UserSignUpParams({
    required this.email,
    required this.name,
    required this.password,
  });
}
