import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/core/usecase.dart';
import 'package:health_online_doctor/domain/appointment/repository/appointment_repository.dart';

import '../../../service_locator.dart';

class GetAppointmentTodayUseCase implements UseCase<Either, int> {
  @override
  Future<Either> call({int? params}) async {
    return await sl<AppointmentRepository>().getAppointment(params!);
  }
}
