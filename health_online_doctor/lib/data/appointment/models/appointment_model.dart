import 'package:health_online_doctor/domain/appointment/entity/appointment_entity.dart';

class AppointmentModel {
  final String id;
  final String userId;
  final String dayBooking;
  final int hourBooking;
  final String victimName;
  final String description;
  final int age;
  final int status;

  const AppointmentModel({
    required this.id,
    required this.userId,
    required this.dayBooking,
    required this.hourBooking,
    required this.victimName,
    required this.description,
    required this.age,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userId': this.userId,
      'dayBooking': this.dayBooking,
      'hourBooking': this.hourBooking,
      'victimName': this.victimName,
      'description': this.description,
      'age': this.age,
      'status': this.status,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: (map['id'] as String) ?? "",
      userId: map['userId'] as String ?? "",
      dayBooking: map['dayBooking'] as String ?? "",
      hourBooking: map['hourBooking'] as int ?? 0,
      victimName: map['victimName'] as String ?? "",
      description: map['description'] as String ?? "",
      age: map['age'] as int ?? 0,
      status: map['status'] as int ?? 0,
    );
  }
}

extension AppointmentModelToEntity on AppointmentModel {
  AppointmentEntity toEntity() {
    return AppointmentEntity(
        id: id,
        userId: userId,
        dayBooking: dayBooking,
        hourBooking: hourBooking,
        victimName: victimName,
        description: description,
        age: age,
        status: status);
  }
}
