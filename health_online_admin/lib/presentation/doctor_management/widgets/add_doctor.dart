import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/data/doctor/models/doctor_model_createReq.dart';
import 'package:health_online_admin/domain/doctor/usecase/add_doctor_usecase.dart';

import '../../../common/bloc/button/button_state.dart';
import '../../../common/bloc/button/button_state_cubit.dart';

class AddDoctor extends StatelessWidget {
  const AddDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddDoctorDialog(context),
      tooltip: 'Thêm Thuốc mới',
      child: const Icon(Icons.add),
    );
  }

  void _showAddDoctorDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController specializedController = TextEditingController();

    void onAdd(BuildContext context) {
      if (emailController.text == '' ||
          passwordController.text == '' ||
          nameController.text == '' ||
          descriptionController.text == '' ||
          specializedController.text == '') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Phải điền đủ tất cả các field")));
      } else {
        context.read<ButtonStateCubit>().execute(
            usecase: AddDoctorUseCase(),
            params: DoctorModelCreateReq(
                email: emailController.text,
                password: passwordController.text,
                name: nameController.text,
                description: descriptionController.text,
                specialized: specializedController.text));
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (BuildContext context) => ButtonStateCubit(),
          child: AlertDialog(
            title: const Text('Thêm thuốc mới'),
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
                    const SnackBar(content: Text("Thêm thuốc thành công")),
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
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Tên'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Mô tả'),
                  ),
                  TextField(
                    controller: specializedController,
                    decoration:
                        const InputDecoration(labelText: 'Chuyên ngành'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Hủy'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Builder(builder: (context) {
                return TextButton(
                  child: const Text('Thêm'),
                  onPressed: () {
                    onAdd(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
