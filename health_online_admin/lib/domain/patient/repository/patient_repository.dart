import 'package:dartz/dartz.dart';
import 'package:health_online_admin/data/patient/models/user_model_createReq.dart';

import '../../../data/patient/models/patient_model.dart';

abstract class PatientRepository{
  Future<Either> getPatient(String email);
  Future<Either> addPatient(UserModelCreateReq user);
  Future<Either> updatePatient(PatientModel user);
  Future<Either> deletePatient(String id);
}