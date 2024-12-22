

import '../../../domain/prescription/entity/medicine_entity.dart';

class MedicineResponse {
  final String name;
  final String unit;
  final String dosage;
  final int quantity;

  const MedicineResponse({
    required this.name,
    required this.unit,
    required this.dosage,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'unit': unit,
      'dosage': dosage,
      'quantity': quantity,
    };
  }

  factory MedicineResponse.fromMap(Map<String, dynamic> map) {
    return MedicineResponse(
      name: map['name'] as String,
      unit: map['unit'] as String,
      dosage: map['dosage'] as String,
      quantity: map['quantity'] as int,
    );
  }
}

extension MedicineResponseToEntity on MedicineResponse {
  MedicineEntity toEntity() {
    return MedicineEntity(
        name: name, unit: unit, dosage: dosage, quantity: quantity);
  }
}
