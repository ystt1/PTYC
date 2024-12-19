import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/data/prescription/models/medical_find.dart';
import 'package:health_online_doctor/data/prescription/models/prescription_post.dart';
import 'package:health_online_doctor/data/prescription/service/prescription_springboot_service.dart';
import 'package:health_online_doctor/domain/prescription/entity/medical_find_entity.dart';
import 'package:health_online_doctor/domain/prescription/repository/prescription_repository.dart';

import '../../../domain/prescription/entity/prescription_entity.dart';
import '../../../service_locator.dart';
import '../models/prescription_response.dart';

class PrescriptionRepositoryImp extends PrescriptionRepository {
  @override
  Future<Either> getPrescription(String appointmentId) async {
    try {
      var prescriptionModel =
          await sl<PrescriptionSpringbootService>().getPrescription(appointmentId);
      return prescriptionModel.fold((error) => Left(error), (data) {
        final PrescriptionEntity prescription =
        (data as PrescriptionResponse).toEntity();

        return Right(prescription);
      });
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> findMedical(String medicalName) async {
    try {
      var medicalModels =
          await sl<PrescriptionSpringbootService>().findMedical(medicalName);
      return medicalModels.fold((error) => Left(error), (data) {
        final List<MedicalFindEntity> medicalEntities = (data as List<MedicalFind>)
            .map((MedicalFind model) => model.toEntity())
            .toList();

        return Right(medicalEntities);
      });
    } catch (e) {

      return Left(e);
    }
  }

  @override
  Future<Either> addPrescription(PrescriptionPost prescription) async {
    return await sl<PrescriptionSpringbootService>().addPrescription(prescription);
  }

}