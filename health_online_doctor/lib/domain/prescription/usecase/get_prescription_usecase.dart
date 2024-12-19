

import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/domain/prescription/repository/prescription_repository.dart';

import '../../../core/usecase.dart';
import '../../../service_locator.dart';

class GetPrescriptionUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {

    return await sl<PrescriptionRepository>().getPrescription(params!);
  }
}
