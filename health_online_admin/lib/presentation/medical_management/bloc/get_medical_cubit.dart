



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/domain/medicine/usecase/get_medical_usecase.dart';
import 'package:health_online_admin/presentation/medical_management/bloc/get_medical_state.dart';

import '../../../service_locator.dart';

class GetMedicalCubit extends Cubit<GetMedicalState> {
  GetMedicalCubit() : super(GetMedicalInitial());

  Future<void> onGet(String name) async {
    try {
      emit(GetMedicalLoading());
      final returnedData = await sl<GetMedicalUseCase>().call(params: name);

      returnedData.fold((error) => emit(GetMedicalFailure(errorMsg: error)),
              (data) {
            emit(GetMedicalSuccess(Medicals: data));
          });
    } catch (e) {
      emit(GetMedicalFailure(errorMsg: e.toString()));
    }
  }
}
