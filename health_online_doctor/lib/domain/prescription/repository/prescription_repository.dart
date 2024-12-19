import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/data/prescription/models/prescription_post.dart';

abstract class PrescriptionRepository{
  Future<Either> getPrescription(String appointmentId);
  Future<Either> findMedical(String medicalName);
  Future<Either> addPrescription(PrescriptionPost prescription);
}