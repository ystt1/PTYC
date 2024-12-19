import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/data/prescription/models/prescription_post.dart';
import 'package:http/http.dart' as http;

import '../../../core/app_constant.dart';
import '../models/medical_find.dart';
import '../models/prescription_response.dart';

abstract class PrescriptionSpringbootService {
  Future<Either> getPrescription(String id);

  Future<Either> findMedical(String name);

  Future<Either> addPrescription(PrescriptionPost prescription);
}

class PrescriptionSpringbootServiceImp extends PrescriptionSpringbootService {
  @override
  Future<Either> getPrescription(String id) async {
    try {
      final uri = Uri.parse(
          "${AppConstant.api}/prescription/get-prescription?idAppointment=$id");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            json.decode(utf8.decode(response.bodyBytes));

        final prescription = PrescriptionResponse.fromMap(responseBody);

        return Right(prescription);
      }
      return const Left("Something went wrong");
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> findMedical(String name) async {
    try {
      final uri =
          Uri.parse("${AppConstant.api}/medicine/get-medical?name=$name");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> responseBody =
            json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;

        final medicals = responseBody
            .map((medical) => MedicalFind.fromMap(medical))
            .toList();
        return Right(medicals);
      }
      return const Left("Something went wrong");
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> addPrescription(PrescriptionPost prescription) async {
    try {
      var body = jsonEncode(prescription.toJson());
      final uri = Uri.parse("${AppConstant.api}/prescription/add-prescription");
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: body);

      final String responseBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        return Right(responseBody);
      }
      return Left(responseBody);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
