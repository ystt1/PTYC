import 'package:health_online_admin/domain/patient/entity/patient_entity.dart';

class PatientModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final int status;

  const PatientModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'fullName': this.name,
      'email': this.email,
      'phoneNumber': this.phone,
      'password': this.password,
      'status': this.status,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] as String,
      name: (map['fullName']??"notFound") as String,
      email: map['email'] as String,
      phone: (map['phoneNumber']??"notFound") as String,
      password: map['password'] as String,
      status: (map['status']??0) as int,
    );
  }
}

extension PatientModelToEntity on PatientModel {
  Patient toEntity() {
    return Patient(
        id: id,
        name: name,
        email: email,
        phone: phone,
        password: password,
        status: status);
  }
}
