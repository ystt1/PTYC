import 'package:dartz/dartz.dart';
import 'package:health_online_admin/core/usecase.dart';
import 'package:health_online_admin/data/medical/models/medicine_model.dart';


import '../../../service_locator.dart';
import '../repository/medical_repository.dart';

class UpdateMedicalUseCase implements UseCase<Either, MedicineModel> {
  @override
  Future<Either> call({MedicineModel? params}) async {
    return await sl<MedicalRepository>().updateMedical(params!);
  }
}
