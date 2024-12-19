import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:health_online_admin/data/patient/models/user_model_createReq.dart';
import 'package:http/http.dart' as http;

import '../../../core/app_constant.dart';
import '../models/patient_model.dart';

abstract class PatientService {
  Future<Either> getAllPatient(String email);

  Future<Either> addPatient(UserModelCreateReq user);

  Future<Either> updatePatient(PatientModel user);

  Future<Either> deletePatient(String id);
}

class PatientServiceImp extends PatientService {
  @override
  Future<Either> getAllPatient(String email) async {
    try {
      final uri = Uri.parse('${AppConstant.api}/admin/get-user?email=$email');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> responseBody =
            json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        final users =
            responseBody.map((data) => PatientModel.fromMap(data)).toList();

        return Right(users);
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return Left(responseBody["message"] ?? "Unknown error");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> addPatient(UserModelCreateReq user) async {
    try {
      String request = user.toJson();
      final uri = Uri.parse('http://localhost:8080/user');
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: request);
      final Map<String, dynamic> responseBody =
          jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return Right(responseBody['message']);
      } else {
        return Left(responseBody['message'] ?? "Unknown error");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> updatePatient(PatientModel user) async {
    try {
      String request = jsonEncode(user.toMap());
      final uri = Uri.parse('http://localhost:8080/admin/edit-user');
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: request);
      final String responseBody =
      utf8.decode(response.bodyBytes);

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
  Future<Either> deletePatient(String id) async {
    try {
      final uri = Uri.parse('${AppConstant.api}/admin/delete-user?id=$id');
      final response = await http.post(uri);
      final String responseBody =
      utf8.decode(response.bodyBytes);

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
