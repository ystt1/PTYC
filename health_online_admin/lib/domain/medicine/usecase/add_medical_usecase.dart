import 'package:dartz/dartz.dart';
import 'package:health_online_admin/core/usecase.dart';
import 'package:health_online_admin/data/medical/models/medical_add_model.dart';

import '../../../service_locator.dart';
import '../repository/medical_repository.dart';

class AddMedicalUseCase implements UseCase<Either, MedicineModelAdd> {
  @override
  Future<Either> call({MedicineModelAdd? params}) async {
    return await sl<MedicalRepository>().addMedical(params!);
  }
}
