class MedicineModelAdd {
  final String name;
  final String unit;
  final int quantity;

  MedicineModelAdd({ required this.name, required this.unit, required this.quantity});

  Map<String, dynamic> toMap() {
    return {

      'name': name,
      'unit': unit,
      'quantity': quantity,
    };
  }

  factory MedicineModelAdd.fromMap(Map<String, dynamic> map) {
    return MedicineModelAdd(

      name: map['name'] as String,
      unit: map['unit'] as String,
      quantity: map['quantity'] as int,
    );
  }
}

