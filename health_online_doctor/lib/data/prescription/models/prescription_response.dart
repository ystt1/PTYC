

import '../../../domain/prescription/entity/prescription_entity.dart';
import 'medicine_response.dart';

class PrescriptionResponse {
  final String note;
  final String diagnosis;
  final List<MedicineResponse> medicines;

  PrescriptionResponse(
      {required this.note, required this.diagnosis, required this.medicines});

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'diagnosis': diagnosis,
      'medicines': medicines,
    };
  }

  factory PrescriptionResponse.fromMap(Map<String, dynamic> map) {
    return PrescriptionResponse(
      note: map['note'] as String,
      diagnosis: map['diagnosis'] as String,
      medicines: (map['medicineInPrescription'] as List)
          .map((medicineMap) => MedicineResponse.fromMap(medicineMap))
          .toList(),
    );
  }
}

extension PrescriptionResponseToEntity on PrescriptionResponse {
  PrescriptionEntity toEntity() {
    return PrescriptionEntity(
        note: note,
        diagnosis: diagnosis,
        medicines: medicines.map((data) => data.toEntity()).toList());
  }
}
