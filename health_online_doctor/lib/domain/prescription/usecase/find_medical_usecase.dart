import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/core/usecase.dart';

import '../../../service_locator.dart';
import '../repository/prescription_repository.dart';

class FindMedicalUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<PrescriptionRepository>().findMedical(params!);
  }
}
