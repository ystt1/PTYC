import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_doctor/domain/appointment/usecase/get_appointment_today_usecase.dart';
import 'package:health_online_doctor/presentation/dashboard/bloc/get_appointment_today_state.dart';

import '../../../service_locator.dart';

class GetAppointmentTodayCubit extends Cubit<GetAppointmentTodayState> {
  GetAppointmentTodayCubit() : super(GetAppointmentTodayInitial());

  Future<void> getAppointment(int type) async {
    try {
      emit(GetAppointmentTodayLoading());
      var returnedData =
      await sl<GetAppointmentTodayUseCase>().call(params: type);

      returnedData.fold((error) => emit(GetAppointmentTodayFailure(error)),
              (data) {
            emit(GetAppointmentTodaySuccess(data));
          });
    }
    catch (e)
    {
      emit(GetAppointmentTodayFailure(e.toString()));
    }
  }
}
