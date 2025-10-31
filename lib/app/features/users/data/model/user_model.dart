import 'package:reqres_user_app/app/features/users/domain/entity/user.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'user',primaryKeys: ['id'])
class UserModel extends User {

  UserModel({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String avatar
  }) : super(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar
  );


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatar: json['avatar'] as String,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }


  factory UserModel.fromEntity(User entity) {
    return UserModel(
        id: entity.id,
        email: entity.email,
        firstName: entity.firstName,
        lastName: entity.lastName,
        avatar: entity.avatar
    );
  }
}