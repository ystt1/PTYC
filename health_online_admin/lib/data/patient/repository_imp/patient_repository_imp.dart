import 'package:dartz/dartz.dart';
import 'package:health_online_admin/data/patient/models/patient_model.dart';
import 'package:health_online_admin/data/patient/models/user_model_createReq.dart';
import 'package:health_online_admin/data/patient/service/patient_service.dart';
import 'package:health_online_admin/domain/patient/repository/patient_repository.dart';

import '../../../service_locator.dart';

class PatientRepositoryImp extends PatientRepository{
  @override
  Future<Either> getPatient(String email) async {
    try {
      Either response;
      response = await sl<PatientService>().getAllPatient(email);
      return response.fold((error) => Left(error), (data) {
        final users = (data as List<PatientModel>)
            .map((PatientModel e) => e.toEntity())
            .toList();
        return Right(users);
      });
    } catch (e) {

      return Left(e.toString());
    }
  }

  @override
  Future<Either> addPatient(UserModelCreateReq user) async {
    return await sl<PatientService>().addPatient(user);
  }

  @override
  Future<Either> updatePatient(PatientModel user) async {
    return await sl<PatientService>().updatePatient(user);
  }

  @override
  Future<Either> deletePatient(String id) async {
    return await sl<PatientService>().deletePatient(id);
  }
}