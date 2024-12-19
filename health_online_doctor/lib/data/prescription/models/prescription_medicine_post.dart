class PrescriptionMedicinePost {
  final String idMedicine;
  final String dosage;
  final int quantity;

  PrescriptionMedicinePost(
      {required this.idMedicine, required this.dosage, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'idMedicine': idMedicine,
      'dosage': dosage,
      'quantity': quantity,
    };
  }
}
