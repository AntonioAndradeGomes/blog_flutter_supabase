import 'package:blog_app/src/core/error/failure.dart';
import 'package:blog_app/src/core/usecases/usecase.dart';
import 'package:blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements Usecase<UserEntity, UserLoginParams> {
  final AuthRepository repository;

  UserLogin(
    this.repository,
  );

  @override
  Future<Either<Failure, UserEntity>> call(
    UserLoginParams params,
  ) async {
    return await repository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
