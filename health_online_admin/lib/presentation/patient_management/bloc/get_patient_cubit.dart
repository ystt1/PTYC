import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/domain/patient/usecase/get_patient_usecase.dart';
import 'package:health_online_admin/presentation/patient_management/bloc/get_patient_state.dart';
import 'package:health_online_admin/service_locator.dart';

class GetPatientCubit extends Cubit<GetPatientState> {
  GetPatientCubit() : super(GetPatientInitial());

  Future<void> onGet(String name) async {
    try {
      emit(GetPatientLoading());
      final returnedData = await sl<GetPatientUseCase>().call(params: name);

      returnedData.fold((error) => emit(GetPatientFailure(errorMsg: error)),
          (data) {
        emit(GetPatientSuccess(patients: data));
      });
    } catch (e) {
      emit(GetPatientFailure(errorMsg: e.toString()));
    }
  }
}
