import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/prescription/usecase/get_prescription_usecase.dart';
import '../../../service_locator.dart';
import 'get_prescription_state.dart';

class GetPrescriptionCubit extends Cubit<GetPrescriptionState> {
  GetPrescriptionCubit() : super(GetPrescriptionStateLoading());

  Future<void> onLoading(String id) async {
    try {
      GetPrescriptionStateLoading();
      final response = await sl<GetPrescriptionUseCase>().call(params: id);

      response.fold(
          (error) => emit(GetPrescriptionStateFailure(errorMsg: error)),
          (data) =>
              emit(GetPrescriptionStateSuccess(prescriptionEntity: data)));
    } catch (e) {
      emit(GetPrescriptionStateFailure(errorMsg: e.toString()));
    }
  }
}
