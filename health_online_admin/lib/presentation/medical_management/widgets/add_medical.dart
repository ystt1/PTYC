import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/data/medical/models/medical_add_model.dart';

import '../../../common/bloc/button/button_state.dart';
import '../../../common/bloc/button/button_state_cubit.dart';
import '../../../domain/medicine/usecase/add_medical_usecase.dart';


class AddMedical extends StatelessWidget {
  const AddMedical({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddMedicalDialog(context),
      tooltip: 'Thêm Thuốc mới',
      child: const Icon(Icons.add),
    );
  }

  void _showAddMedicalDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController unitController = TextEditingController();
    TextEditingController quantityController = TextEditingController();


    void onAdd(BuildContext context) {
      if (nameController.text == '' ||
          unitController.text == '' ||
          quantityController.text == ''
          ) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Phải điền đủ tất cả các field")));
      } else {
        context.read<ButtonStateCubit>().execute(
            usecase: AddMedicalUseCase(),
          params: MedicineModelAdd(name: nameController.text,unit: unitController.text,quantity: int.parse(quantityController.text))
           );
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
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Tên'),
                  ),
                  TextField(
                    controller: unitController,
                    decoration: const InputDecoration(labelText: 'Đơn vị'),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: quantityController,
                    decoration:
                        const InputDecoration(labelText: 'Số lượng'),
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
