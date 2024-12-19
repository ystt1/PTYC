import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/core/app_constant.dart';
import 'package:health_online_doctor/data/auth/models/login_input.dart';
import 'package:health_online_doctor/data/auth/models/login_response.dart';
import 'package:http/http.dart' as http;

import '../../../core/user_storage.dart';

abstract class AuthServiceSpringboot {
  Future<Either> login(LoginInput user);
}

class AuthServiceSpringbootImp extends AuthServiceSpringboot {
  @override
  Future<Either> login(LoginInput user) async {
    try {
      final uri = Uri.parse(
          'http://localhost:8080/doctor/login?email=${user.email}&password=${user.password}');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
        jsonDecode(utf8.decode(response.bodyBytes));
        UserStorage.setId(responseBody['id']);
        return Right(LoginResponse.fromMap(responseBody));
      } else {
        return const Left("Login Fail");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
