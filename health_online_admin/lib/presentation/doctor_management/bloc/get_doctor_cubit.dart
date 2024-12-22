import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/domain/doctor/usecase/get_doctor_usecase.dart';
import 'package:health_online_admin/presentation/Doctor_management/bloc/get_Doctor_state.dart';

import '../../../service_locator.dart';

class GetDoctorCubit extends Cubit<GetDoctorState> {
  GetDoctorCubit() : super(GetDoctorInitial());

  Future<void> onGet(String name) async {
    try {
      emit(GetDoctorLoading());
      final returnedData = await sl<GetDoctorUseCase>().call(params: name);

      returnedData.fold((error) => emit(GetDoctorFailure(errorMsg: error)),
              (data) {
            emit(GetDoctorSuccess(doctors: data));
          });
    } catch (e) {
      emit(GetDoctorFailure(errorMsg: e.toString()));
    }
  }
}
