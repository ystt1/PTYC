import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_doctor/domain/prescription/usecase/find_medical_usecase.dart';
import 'package:health_online_doctor/presentation/prescription/bloc/get_medical_state.dart';

import '../../../service_locator.dart';

class GetMedicalCubit extends Cubit<GetMedicalState> {
  GetMedicalCubit() : super(GetMedicalInitialState());

  Future<void> onFinding(String name) async {
    try {
      emit(GetMedicalLoading());
      final response = await sl<FindMedicalUseCase>().call(params: name);

      response.fold((error) => emit(GetMedicalFailure(errorMsg: error)),
          (data) {

        emit(GetMedicalSuccess(medicals: data));
      });
    } catch (e) {

      emit(GetMedicalFailure(errorMsg: e.toString()));
    }
  }
}
