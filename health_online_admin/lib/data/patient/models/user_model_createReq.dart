import 'dart:convert';

class UserModelCreateReq {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;

  UserModelCreateReq({required this.email, required this.password, required this.fullName, required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModelCreateReq.fromMap(Map<String, dynamic> map) {
    return UserModelCreateReq(
      email: map['email'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

}

// extension UserModelCreateReqToEntity on UserModelCreateReq {
//   UserEntity toEntity() {
//     return UserEntity(
//       email: email,
//       password: password,
//       fullName: fullName,
//     );
//   }
// }
