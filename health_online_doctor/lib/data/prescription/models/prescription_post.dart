import 'package:health_online_doctor/data/prescription/models/prescription_medicine_post.dart';

class PrescriptionPost {
  final String idAppointment;
  final String diagnosis;
  final String note;
  final List<PrescriptionMedicinePost> prescriptionMedicineList;

  PrescriptionPost({required this.idAppointment,
    required this.diagnosis,
    required this.note,
    required this.prescriptionMedicineList});

  Map<String, dynamic> toJson() {
    return {
      'idAppointment': idAppointment,
      'diagnosis': diagnosis,
      'note': note,
      'prescriptionMedicineList': prescriptionMedicineList.map((medicine) =>
          medicine.toJson()).toList(),
    };
  }
}
