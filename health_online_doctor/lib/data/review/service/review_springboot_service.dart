import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/core/user_storage.dart';

import '../../../core/app_constant.dart';
import 'package:http/http.dart' as http;

import '../models/review_response.dart';

abstract class ReviewSpringbootService {
  Future<Either> getReview();
}

class ReviewSpringbootServiceImp extends ReviewSpringbootService {
  @override
  Future<Either> getReview() async {
    try {
      final uri = Uri.parse(
          '${AppConstant.api}/get-review?doctorId=${UserStorage.getId()}');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> responseBody =
            json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        final reviews =
            responseBody.map((data) => ReviewResponse.fromMap(data)).toList();

        return Right(reviews);
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return Left(responseBody["message"] ?? "Unknown error");
      }
    } catch (e) {
      return Left(e);
    }
  }
}
