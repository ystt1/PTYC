import 'package:health_online_doctor/domain/prescription/entity/medical_find_entity.dart';

import '../../../domain/prescription/entity/medicine_entity.dart';

class MedicalFind {
  final String id;
  final String name;
  final String unit;
  final int quantity;

  const MedicalFind({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'unit': this.unit,
      'quantity': this.quantity,
    };
  }

  factory MedicalFind.fromMap(Map<String, dynamic> map) {
    return MedicalFind(
      id: map['id'] as String,
      name: map['name'] as String,
      unit: map['unit'] as String,
      quantity: map['quantity'] as int,
    );
  }
}

extension MedicineResponseToEntity on MedicalFind {
  MedicalFindEntity toEntity() {
    return MedicalFindEntity(
        name: name, unit: unit, quantity: quantity, id: id);
  }
}
