import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDatasourceImp extends AuthDatasource {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasourceImp(
    this.supabaseClient,
  );

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException('User is null!!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      if (response.user == null) {
        throw const ServerException(
          'User is null!',
        );
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
