import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDatasourceImp implements AuthDatasource {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasourceImp(
    this.supabaseClient,
  );

  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
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
      return response.user!.id;
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
