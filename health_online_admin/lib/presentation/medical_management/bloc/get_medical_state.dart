

import '../../../domain/medicine/entity/medicine_entity.dart';

abstract class GetMedicalState{}

class GetMedicalInitial extends GetMedicalState{}

class GetMedicalLoading extends GetMedicalState{}

class GetMedicalSuccess extends GetMedicalState{
  final List<Medicine> Medicals;
  GetMedicalSuccess({required this.Medicals});
}

class GetMedicalFailure extends GetMedicalState{
  final String errorMsg;

  GetMedicalFailure({required this.errorMsg});
}