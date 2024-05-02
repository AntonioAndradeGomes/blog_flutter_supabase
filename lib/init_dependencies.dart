import 'package:blog_app/src/features/auth/data/datasources/auth_datasource.dart';
import 'package:blog_app/src/features/auth/data/datasources/remote/auth_remote_datasource_imp.dart';
import 'package:blog_app/src/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:blog_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/src/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: dotenv.env['supabaseUrl']!,
    anonKey: dotenv.env['supabaseKey']!,
  );

  serviceLocator.registerLazySingleton<SupabaseClient>(
    () => supabase.client,
  );

  _initAuth();
}

void _initAuth() {
  serviceLocator.registerSingleton<AuthDatasource>(
    AuthRemoteDatasourceImp(
      serviceLocator<SupabaseClient>(),
    ),
  );

  serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImp(
      serviceLocator<AuthDatasource>(),
    ),
  );
  serviceLocator.registerSingleton<UserSignUp>(
    UserSignUp(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerSingleton<UserLogin>(
    UserLogin(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerSingleton<CurrentUser>(
    CurrentUser(
      serviceLocator<AuthRepository>(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator<UserSignUp>(),
      userLogin: serviceLocator<UserLogin>(),
      currentUser: serviceLocator<CurrentUser>(),
    ),
  );
}
