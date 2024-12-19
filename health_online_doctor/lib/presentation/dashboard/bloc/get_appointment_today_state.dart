import 'package:health_online_doctor/domain/appointment/entity/appointment_entity.dart';

abstract class GetAppointmentTodayState{
}

class GetAppointmentTodayInitial extends GetAppointmentTodayState{}

class GetAppointmentTodayLoading extends GetAppointmentTodayState{}

class GetAppointmentTodaySuccess extends GetAppointmentTodayState{
  final List<AppointmentEntity> appointments;

  GetAppointmentTodaySuccess(this.appointments);
}

class GetAppointmentTodayFailure extends GetAppointmentTodayState{
  final String error;

  GetAppointmentTodayFailure(this.error);
}