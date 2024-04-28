import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
