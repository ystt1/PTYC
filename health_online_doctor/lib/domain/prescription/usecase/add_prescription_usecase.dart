import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/core/usecase.dart';
import 'package:health_online_doctor/data/prescription/models/prescription_post.dart';

import '../../../service_locator.dart';
import '../repository/prescription_repository.dart';

class AddPrescriptionUseCase implements UseCase<Either, PrescriptionPost> {
  @override
  Future<Either> call({PrescriptionPost? params}) {
    return sl<PrescriptionRepository>().addPrescription(params!);
  }
}
