import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/button/button_state.dart';
import '../../../common/bloc/button/button_state_cubit.dart';
import '../../../data/patient/models/user_model_createReq.dart';
import '../../../domain/patient/usecase/add_patient_usecase.dart';

class AddPatient extends StatelessWidget {
  const AddPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddPatientDialog(context),
      tooltip: 'Thêm bệnh nhân mới',
      child: const Icon(Icons.add),
    );
  }

  void _showAddPatientDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void onAdd(BuildContext context) {
      if (nameController.text == '' ||
          emailController.text == '' ||
          phoneController.text == '' ||
          passwordController.text == '') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Phải điền đủ tất cả các field")));
      } else {
        context.read<ButtonStateCubit>().execute(
            usecase: AddPatientUseCase(),
            params: UserModelCreateReq(
                email: emailController.text,
                password: passwordController.text,
                fullName: nameController.text,
                phoneNumber: phoneController.text));
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (BuildContext context) => ButtonStateCubit(),
          child: AlertDialog(
            title: const Text('Thêm bệnh nhân mới'),
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
                    const SnackBar(content: Text("Thêm bệnh nhân thành công")),
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
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: phoneController,
                    decoration:
                        const InputDecoration(labelText: 'Số điện thoại'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Mật khẩu'),
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
                    child: const Text('Thêm'),
                    onPressed: () {
                      onAdd(context);
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
}
