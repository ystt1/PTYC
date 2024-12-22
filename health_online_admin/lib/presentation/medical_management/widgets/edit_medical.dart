import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/common/bloc/button/button_state.dart';
import 'package:health_online_admin/data/medical/models/medicine_model.dart';
import 'package:health_online_admin/domain/medicine/entity/medicine_entity.dart';
import 'package:health_online_admin/domain/medicine/usecase/update_medical_usecase.dart';


import '../../../common/bloc/button/button_state_cubit.dart';


void showEditMedicalDialog(BuildContext context, Medicine medical) {
  TextEditingController nameController =
      TextEditingController(text: medical.name);

  TextEditingController unitController =
      TextEditingController(text: medical.unit);
  TextEditingController quantityController =
      TextEditingController(text: medical.quantity.toString());
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
                  controller: unitController,
                  decoration: const InputDecoration(labelText: 'Đơn vị'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Lượng tồn'),
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
                    if(nameController.text!=''&&unitController.text!=''&&quantityController.text!='') {
                      context.read<ButtonStateCubit>().execute(
                          usecase: UpdateMedicalUseCase(),
                        params: MedicineModel(id: medical.id, name: nameController.text, unit: unitController.text, quantity:int.parse(quantityController.text), status: medical.status)
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
