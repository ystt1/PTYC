import 'package:health_online_admin/domain/doctor/entity/doctor_entity.dart';

class DoctorModel {
  final String id;
  final String name;
  final String password;
  final String email;
  final String description;
  final String specialized;
  final int status;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.description,
    required this.specialized,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'email': email,
      'description': description,
      'specialized': specialized,
      'status': status,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] as String,
      name: map['name'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      description: map['description'] as String,
      specialized: map['specialized'] as String,
      status: (map['status']??0) as int,
    );
  }
}

extension PatientModelToEntity on DoctorModel {
  DoctorEntity toEntity() {
    return DoctorEntity(
        id: id,
        name: name,
        password: password,
        email: email,
        description: description,
        specialized: specialized,
        status: status);
  }
}
