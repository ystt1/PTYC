import 'package:dartz/dartz.dart';
import 'package:health_online_admin/core/usecase.dart';
import 'package:health_online_admin/domain/doctor/repository/doctor_repository.dart';


import '../../../service_locator.dart';

class DeleteDoctorUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<DoctorRepository>().deleteDoctor(params!);
  }
}
