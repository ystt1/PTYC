import 'package:health_online_doctor/domain/prescription/entity/medical_find_entity.dart';

abstract class GetMedicalState{
}

class GetMedicalInitialState extends GetMedicalState {}

class GetMedicalLoading extends GetMedicalState{}

class GetMedicalSuccess extends GetMedicalState{
  final List<MedicalFindEntity> medicals;

  GetMedicalSuccess({required this.medicals});
}

class GetMedicalFailure extends GetMedicalState{
  final String errorMsg;
  GetMedicalFailure({required this.errorMsg});
}