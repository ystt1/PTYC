import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/common/bloc/button/button_state.dart';
import 'package:health_online_admin/data/patient/models/patient_model.dart';
import 'package:health_online_admin/domain/patient/usecase/update_patient_usecase.dart';

import '../../../common/bloc/button/button_state_cubit.dart';
import '../../../domain/patient/entity/patient_entity.dart';

void showEditPatientDialog(BuildContext context, Patient patient) {
  TextEditingController nameController =
      TextEditingController(text: patient.name);

  TextEditingController phoneController =
      TextEditingController(text: patient.phone);
  TextEditingController passwordController =
      TextEditingController(text: '');
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (BuildContext context) => ButtonStateCubit(),
        child: AlertDialog(
          title: const Text('Sửa thông tin bệnh nhân'),
          content: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (BuildContext context, state) {
              if (state is ButtonLoadingState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 10),
                        Text("Đang xử lý..."),
                      ],
                    ),
                  ),
                );
              }
              if (state is ButtonSuccessState) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sửa bệnh nhân thành công")),
                );
                Navigator.of(context).pop(); // Đóng dialog
              }
              if (state is ButtonFailureState) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Lỗi: ${state.errorMessage}")),
                );
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Tên'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Mật khẩu'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Số điện thoại'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Hủy'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Builder(
              builder: (context) {
                return TextButton(
                  child: const Text('Lưu'),
                  onPressed: () {
                    if(nameController.text!=''&&phoneController.text!=''&&passwordController.text!='') {
                      context.read<ButtonStateCubit>().execute(
                          usecase: UpdatePatientUsecase(),
                          params: PatientModel(
                              id: patient.id,
                              name: nameController.text,
                              email: patient.email,
                              phone: phoneController.text,
                              password: passwordController.text,
                              status: patient.status));
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Các trường phải khác rỗng")),

                      );
                    }
                  },
                );
              }
            ),
          ],
        ),
      );
    },
  );
}
