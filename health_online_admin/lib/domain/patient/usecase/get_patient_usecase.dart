import 'package:dartz/dartz.dart';
import 'package:health_online_admin/core/usecase.dart';
import 'package:health_online_admin/domain/patient/repository/patient_repository.dart';

import '../../../service_locator.dart';

class GetPatientUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<PatientRepository>().getPatient(params!);
  }
}
