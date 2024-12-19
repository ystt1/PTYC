import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/common/bloc/button/button_state.dart';
import 'package:health_online_admin/common/bloc/button/button_state_cubit.dart';
import 'package:health_online_admin/domain/patient/usecase/delete_patient_usecase.dart';

void deletePatient(BuildContext context, String patientId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (BuildContext context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (BuildContext context, state) {
            if (state is ButtonLoadingState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Center(child: CircularProgressIndicator())));
            }
            if (state is ButtonFailureState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            if (state is ButtonLoadingState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Xóa thành công')));
              Navigator.of(context).pop();
            }
          },
          child: AlertDialog(
            title: const Text('Xác nhận'),
            content:
                const Text('Bạn có chắc chắn muốn xóa bệnh nhân này không?'),
            actions: [
              TextButton(
                child: const Text('Hủy'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Builder(builder: (context) {
                return TextButton(
                  child: const Text('Xóa', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    context.read<ButtonStateCubit>().execute(
                        usecase: DeletePatientUseCase(), params: patientId);
                  },
                );
              }),
            ],
          ),
        ),
      );
    },
  );
}
