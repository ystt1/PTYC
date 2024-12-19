import 'package:health_online_admin/domain/patient/entity/patient_entity.dart';

abstract class GetPatientState{}

class GetPatientInitial extends GetPatientState{}

class GetPatientLoading extends GetPatientState{}

class GetPatientSuccess extends GetPatientState{
  final List<Patient> patients;
  GetPatientSuccess({required this.patients});
}

class GetPatientFailure extends GetPatientState{
  final String errorMsg;

  GetPatientFailure({required this.errorMsg});
}