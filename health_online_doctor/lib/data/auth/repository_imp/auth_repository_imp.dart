import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/data/auth/models/login_input.dart';
import 'package:health_online_doctor/data/auth/models/login_response.dart';
import 'package:health_online_doctor/data/auth/service/auth_service_springboot.dart';

import '../../../domain/auth/repository/auth_repository.dart';
import '../../../service_locator.dart';

class AuthRepositoryImp extends AuthRepository {
  @override
  Future<Either> login(LoginInput user) async {
    var response = await sl<AuthServiceSpringboot>().login(user);
    return response.fold((error) => Left(error), (data) {
      final userEntity = (data as LoginResponse).toEntity();
      return Right(userEntity);
    });
  }
}
