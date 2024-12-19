import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/common/bloc/button/button_state.dart';
import 'package:health_online_admin/data/doctor/models/doctor_model.dart';
import 'package:health_online_admin/domain/doctor/entity/doctor_entity.dart';

import '../../../common/bloc/button/button_state_cubit.dart';
import '../../../domain/doctor/usecase/update_doctor_usecase.dart';


void showEditDoctorDialog(BuildContext context, DoctorEntity doctor) {
  TextEditingController nameController =
      TextEditingController(text: doctor.name);
  TextEditingController passwordController=
  TextEditingController(text: doctor.password);
  TextEditingController descriptionController =
      TextEditingController(text: doctor.description);
  TextEditingController specializedController =
      TextEditingController(text: doctor.specialized);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (BuildContext context) => ButtonStateCubit(),
        child: AlertDialog(
          title: const Text('Sửa thông tin Bác sĩ'),
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
                  const SnackBar(content: Text("Sửa thông tin bác sĩ thành công")),
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
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Mô tả'),
                ),
                TextField(
                  controller: specializedController,
                  decoration: const InputDecoration(labelText: 'Chuyên ngành'),
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
                    if(nameController.text!=''&&passwordController.text!=''&&descriptionController.text!=''&&specializedController.text!='') {
                      context.read<ButtonStateCubit>().execute(
                          usecase: UpdateDoctorUseCase(),
                       params: DoctorModel(id: doctor.id, name: nameController.text, password: passwordController.text, email: doctor.email, description: descriptionController.text, specialized: specializedController.text , status: doctor.status)
                          );
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
