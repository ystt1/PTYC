import 'package:dartz/dartz.dart';
import 'package:health_online_admin/core/usecase.dart';
import 'package:health_online_admin/data/doctor/models/doctor_model.dart';
import 'package:health_online_admin/domain/doctor/repository/doctor_repository.dart';



import '../../../service_locator.dart';


class UpdateDoctorUseCase implements UseCase<Either, DoctorModel> {
  @override
  Future<Either> call({DoctorModel? params}) async {
    return await sl<DoctorRepository>().updateDoctor(params!);
  }
}
