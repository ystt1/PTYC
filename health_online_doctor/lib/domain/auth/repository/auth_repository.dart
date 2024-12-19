import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/data/auth/models/login_input.dart';

abstract class AuthRepository{
  Future<Either> login(LoginInput user);
}