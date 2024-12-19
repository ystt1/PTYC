import 'package:dartz/dartz.dart';
import 'package:health_online_admin/core/usecase.dart';
import 'package:health_online_admin/data/doctor/models/doctor_model_createReq.dart';
import 'package:health_online_admin/domain/doctor/repository/doctor_repository.dart';

import '../../../service_locator.dart';

class AddDoctorUseCase implements UseCase<Either, DoctorModelCreateReq> {
  @override
  Future<Either> call({DoctorModelCreateReq? params}) async {
    return await sl<DoctorRepository>().addDoctor(params!);
  }
}
