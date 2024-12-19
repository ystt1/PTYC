import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../domain/review/usecase/get_review_usecase.dart';
import '../../../service_locator.dart';
import 'get_review_state.dart';

class GetReviewCubit extends Cubit<GetReviewState> {
  GetReviewCubit() : super(GetReviewStateInitial());

  Future<void> getReview() async {
    try {
      emit(GetReviewStateLoading());
      var response = await sl<GetReviewUseCase>().call();
      response.fold((error) => emit(GetReviewStateFailure(errorMsg: error)),
              (reviews) => emit(GetReviewStateSuccess(reviews: reviews)));
    } catch (e) {
      print(e);
      emit(GetReviewStateFailure(errorMsg: e.toString()));
    }
  }
}
