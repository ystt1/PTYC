import 'package:dartz/dartz.dart';
import 'package:health_online_admin/data/doctor/models/doctor_model.dart';
import 'package:health_online_admin/data/doctor/models/doctor_model_createReq.dart';
import 'package:health_online_admin/data/doctor/service/doctor_service.dart';
import 'package:health_online_admin/domain/doctor/repository/doctor_repository.dart';


import '../../../service_locator.dart';

class DoctorRepositoryImp extends DoctorRepository{
  @override
  Future<Either> getDoctor(String name) async {
    try {
      var response;
      response = await sl<DoctorService>().getAllDoctor(name);
      return response.fold((error) => Left(error), (data) {
        final users = (data as List<DoctorModel>)
            .map((DoctorModel e) => e.toEntity())
            .toList();
        return Right(users);
      });
    } catch (e) {

      return Left(e.toString());
    }
  }

  @override
  Future<Either> addDoctor(DoctorModelCreateReq doctor) async {
    return await sl<DoctorService>().addDoctor(doctor);
  }

  @override
  Future<Either> updateDoctor(DoctorModel doctor) async {
    return await sl<DoctorService>().updateDoctor(doctor);
  }

  @override
  Future<Either> deleteDoctor(String id) async {
    return await sl<DoctorService>().deleteDoctor(id);
  }
}