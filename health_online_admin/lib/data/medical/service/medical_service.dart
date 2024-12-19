import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../core/app_constant.dart';
import '../models/medical_add_model.dart';
import '../models/medicine_model.dart';
import 'package:http/http.dart' as http;

abstract class MedicalService {
  Future<Either> getAllMedical(String email);

  Future<Either> addMedical(MedicineModelAdd user);

  Future<Either> updateMedical(MedicineModel user);

  Future<Either> deleteMedical(String id);
}

class MedicalServiceImp extends MedicalService {
  @override
  Future<Either> getAllMedical(String email) async {
    try {
      final uri =
          Uri.parse('${AppConstant.api}/medicine/get-medical?name=$email');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> responseBody =
            json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        final users =
            responseBody.map((data) => MedicineModel.fromMap(data)).toList();

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
  Future<Either> addMedical(MedicineModelAdd user) async {
    try {
      String request = jsonEncode(user.toMap());
      final uri = Uri.parse('http://localhost:8080/medicine');
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
  Future<Either> updateMedical(MedicineModel user) async {
    try {
      String request = jsonEncode(user.toMap());

      final uri = Uri.parse('http://localhost:8080/admin/edit-medical');
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
  Future<Either> deleteMedical(String id) async {
    try {
      final uri = Uri.parse('${AppConstant.api}/admin/delete-medicine?id=$id');
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
