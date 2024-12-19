import 'package:dartz/dartz.dart';

import '../../../core/usecase.dart';
import '../../../service_locator.dart';
import '../repository/review_repository.dart';

class GetReviewUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {

    return await sl<ReviewRepository>().getReview();
  }
}
