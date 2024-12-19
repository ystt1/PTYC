import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/core/usecase.dart';
import 'package:health_online_doctor/data/auth/models/login_input.dart';


import '../../../service_locator.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements UseCase<Either,LoginInput> {
  @override
  Future<Either> call({LoginInput? params}) async {
    return await sl<AuthRepository>().login(params!);
  }

}