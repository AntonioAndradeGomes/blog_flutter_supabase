import 'package:blog_app/src/core/error/failure.dart';
import 'package:blog_app/src/core/usecases/usecase.dart';
import 'package:blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(
    this.authRepository,
  );

  @override
  Future<Either<Failure, UserEntity>> call(
    NoParams params,
  ) async {
    return await authRepository.currentUser();
  }
}
