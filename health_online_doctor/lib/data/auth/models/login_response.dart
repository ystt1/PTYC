import 'package:health_online_doctor/common/bloc/auth/user_entity.dart';

class LoginResponse {
  final String email;
  final String name;
  final String description;
  final String specialized;

  LoginResponse(
      {required this.email,
      required this.name,
      required this.description,
      required this.specialized});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'description': description,
      'specialized': specialized,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      email: map['email'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      specialized: map['specialized'] as String,
    );
  }
}

extension LoginResponseToEntity on LoginResponse {
  UserEntity toEntity() {
    return UserEntity(
        email: email,
        name: name,
        description: description,
        specialized: specialized);
  }
}
