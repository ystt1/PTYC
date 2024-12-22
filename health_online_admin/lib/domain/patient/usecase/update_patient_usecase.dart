import 'package:dartz/dartz.dart';
import 'package:health_online_admin/core/usecase.dart';
import 'package:health_online_admin/data/patient/models/patient_model.dart';
import 'package:health_online_admin/domain/patient/repository/patient_repository.dart';

import '../../../service_locator.dart';

class UpdatePatientUsecase implements UseCase<Either, PatientModel> {
  @override
  Future<Either> call({PatientModel? params}) async {
    return await sl<PatientRepository>().updatePatient(params!);
  }
}
