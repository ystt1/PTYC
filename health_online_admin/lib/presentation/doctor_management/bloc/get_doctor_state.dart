
import 'package:health_online_admin/domain/doctor/entity/doctor_entity.dart';

abstract class GetDoctorState{}

class GetDoctorInitial extends GetDoctorState{}

class GetDoctorLoading extends GetDoctorState{}

class GetDoctorSuccess extends GetDoctorState{
final List<DoctorEntity> doctors;

  GetDoctorSuccess({required this.doctors});
}

class GetDoctorFailure extends GetDoctorState{
  final String errorMsg;

  GetDoctorFailure({required this.errorMsg});
}