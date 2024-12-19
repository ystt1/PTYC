import 'package:dartz/dartz.dart';
import 'package:health_online_admin/core/usecase.dart';

import '../../../service_locator.dart';
import '../repository/medical_repository.dart';

class GetMedicalUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<MedicalRepository>().getMedical(params!);
  }
}
