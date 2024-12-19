

import 'package:dartz/dartz.dart';
import 'package:health_online_admin/data/medical/models/medical_add_model.dart';

import '../../../domain/medicine/repository/medical_repository.dart';
import '../../../service_locator.dart';

import '../../patient/models/user_model_createReq.dart';
import '../models/medicine_model.dart';
import '../service/medical_service.dart';

class MedicalRepositoryImp extends MedicalRepository{
  @override
  Future<Either> getMedical(String email) async {
    try {
      var response;
      response = await sl<MedicalService>().getAllMedical(email);
      return response.fold((error) => Left(error), (data) {
        final medicines = (data as List<MedicineModel>)
            .map((MedicineModel e) => e.toEntity())
            .toList();
        return Right(medicines);
      });
    } catch (e) {

      return Left(e.toString());
    }
  }

  @override
  Future<Either> addMedical(MedicineModelAdd user) async {
    return await sl<MedicalService>().addMedical(user);
  }

  @override
  Future<Either> updateMedical(MedicineModel user) async {
    return await sl<MedicalService>().updateMedical(user);
  }

  @override
  Future<Either> deleteMedical(String id) async {
    return await sl<MedicalService>().deleteMedical(id);
  }
}