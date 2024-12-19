import 'package:dartz/dartz.dart';
import 'package:health_online_admin/data/medical/models/medical_add_model.dart';
import 'package:health_online_admin/domain/medicine/entity/medicine_entity.dart';

import '../../../data/medical/models/medicine_model.dart';

abstract class MedicalRepository{
  Future<Either> getMedical(String email);
  Future<Either> addMedical(MedicineModelAdd user);
  Future<Either> updateMedical(MedicineModel user);
  Future<Either> deleteMedical(String id);
}