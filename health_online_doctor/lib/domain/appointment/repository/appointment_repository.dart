import 'package:dartz/dartz.dart';

abstract class AppointmentRepository{
  Future<Either> getAppointment(int type);
}