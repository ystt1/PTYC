import 'package:dartz/dartz.dart';
import 'package:health_online_doctor/data/review/service/review_springboot_service.dart';
import 'package:health_online_doctor/domain/review/repository/review_repository.dart';

import '../../../service_locator.dart';
import '../../appointment/service/appointment_springboot_service.dart';
import '../models/review_response.dart';

class ReviewRepositoryImp extends ReviewRepository {
  @override
  Future<Either> getReview() async {
    try {
      Either response;
      response = await sl<ReviewSpringbootService>().getReview();
      return response.fold((error) => Left(error), (data) {
        final reviews = (data as List<ReviewResponse>)
            .map((ReviewResponse e) => e.toEntity())
            .toList();
        return Right(reviews);
      });
    } catch (e) {

      return Left(e);
    }
  }

}