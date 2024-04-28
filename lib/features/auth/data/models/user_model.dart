import 'package:blog_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.name,
    required super.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
        email: map['email'] ?? '',
        name: map['name'] ?? '',
        id: map['id'] ?? '',
      );
}
