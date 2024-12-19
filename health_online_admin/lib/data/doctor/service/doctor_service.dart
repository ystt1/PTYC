import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:health_online_admin/data/doctor/models/doctor_model.dart';
import 'package:health_online_admin/data/doctor/models/doctor_model_createReq.dart';
import 'package:http/http.dart' as http;

import '../../../core/app_constant.dart';

abstract class DoctorService {
  Future<Either> getAllDoctor(String name);

  Future<Either> addDoctor(DoctorModelCreateReq doctor);

  Future<Either> updateDoctor(DoctorModel doctor);

  Future<Either> deleteDoctor(String id);
}

class DoctorServiceImp extends DoctorService {
  @override
  Future<Either> getAllDoctor(String name) async {
    try {
      final uri =
          Uri.parse('${AppConstant.api}/admin/get-list-doctor?name=$name');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> responseBody =
            json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        final users =
            responseBody.map((data) => DoctorModel.fromMap(data)).toList();
        return Right(users);
      }
      if (response.statusCode == 204) {
        return Left("Không có bất kì bác sĩ nào");
      }
      return Left("Some thing went wrong!");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> addDoctor(DoctorModelCreateReq doctor) async {
    try {
      String request = jsonEncode(doctor.toMap());
      final uri = Uri.parse('${AppConstant.api}/admin/add-doctor');
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: request);
      final responseBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        return Right(responseBody);
      } else {
        return Left(responseBody ?? "Unknown error");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> updateDoctor(DoctorModel doctor) async {
    try {
      String request = jsonEncode(doctor.toMap());

      final uri = Uri.parse('http://localhost:8080/admin/update-doctor');
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: request);
      final String responseBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        return Right(responseBody);
      } else {
        return Left(responseBody);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> deleteDoctor(String id) async {
    try {
      final uri = Uri.parse('${AppConstant.api}/admin/delete-doctor?id=$id');
      final response = await http.post(uri);
      final String responseBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        return Right(responseBody);
      } else {
        return Left(responseBody);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
