import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/data/appointment/models/appointment_model.dart';
import 'package:health_online_doctor/data/appointment/service/appointment_springboot_service.dart';
import 'package:health_online_doctor/domain/appointment/repository/appointment_repository.dart';

import '../../../service_locator.dart';

class AppointmentRepositoryImp extends AppointmentRepository {
  @override
  Future<Either> getAppointment(int type) async {
    try {
      var historiesModel =
          await sl<AppointmentSpringbootService>().getAppointment(type);
      return historiesModel.fold((error) => Left(error), (data) {
        final appointmentEntity = (data as List<AppointmentModel>)
            .map((AppointmentModel model) => model.toEntity())
            .toList();
        return Right(appointmentEntity);
      });
    } catch (e) {
      return Left(e);
    }
  }
}
