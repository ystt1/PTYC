import 'package:dartz/dartz.dart';
import 'package:health_online_admin/data/doctor/models/doctor_model.dart';
import 'package:health_online_admin/data/doctor/models/doctor_model_createReq.dart';

abstract class DoctorRepository{
  Future<Either> getDoctor(String name);
  Future<Either> addDoctor(DoctorModelCreateReq doctor);
  Future<Either> updateDoctor(DoctorModel doctor);
  Future<Either> deleteDoctor(String id);
}