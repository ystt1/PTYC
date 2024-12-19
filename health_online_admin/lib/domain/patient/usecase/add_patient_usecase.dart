import 'package:dartz/dartz.dart';
import 'package:health_online_admin/core/usecase.dart';
import 'package:health_online_admin/data/patient/models/user_model_createReq.dart';
import 'package:health_online_admin/domain/patient/repository/patient_repository.dart';

import '../../../service_locator.dart';

class AddPatientUseCase implements UseCase<Either, UserModelCreateReq> {
  @override
  Future<Either> call({UserModelCreateReq? params}) async {
    return await sl<PatientRepository>().addPatient(params!);
  }
}
