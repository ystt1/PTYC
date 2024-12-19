import 'package:health_online_admin/domain/medicine/entity/medicine_entity.dart';

class MedicineModel {
  final String id;
  final String name;
  final String unit; // Đơn vị tính
  final int quantity; // Số lượng
  final int status;

  const MedicineModel({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'unit': this.unit,
      'quantity': this.quantity,
      'status': this.status,
    };
  }

  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      id: map['id'] as String,
      name: map['name'] as String,
      unit: map['unit'] as String,
      quantity: map['quantity'] as int,
      status: (map['status']??0) as int,
    );
  }
}

extension MedicineModelToEntity on MedicineModel {
  Medicine toEntity() {
    return Medicine(id: id, name: name, unit: unit, quantity: quantity, status: status);
  }
}
