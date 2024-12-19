import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/core/user_storage.dart';

import '../../../core/app_constant.dart';
import 'package:http/http.dart' as http;

import '../models/appointment_model.dart';

abstract class AppointmentSpringbootService{
  Future<Either> getAppointment(int type);
}

class AppointmentSpringbootServiceImp extends AppointmentSpringbootService {
  @override
  Future<Either> getAppointment(int type) async {
    try {
      final uri = Uri.parse(
          "${AppConstant.api}/appointment/get-appointment-today-of-doctor?doctorId=${UserStorage.getId()}&type=$type");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> responseBody =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        final appointments = responseBody
            .map((appointment) => AppointmentModel.fromMap(appointment))
            .toList();

        return Right(appointments);
      }
      return const Left("Something went wrong");
    } catch (e) {
      return Left(e);
    }
  }

}