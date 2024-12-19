import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/presentation/medical_management/bloc/get_medical_cubit.dart';

import '../../../domain/medicine/entity/medicine_entity.dart';
import '../bloc/get_medical_state.dart';
import '../widgets/add_medical.dart';
import '../widgets/delete_medical.dart';
import '../widgets/edit_medical.dart';


class MedicineManagement extends StatefulWidget {
  @override
  _MedicineManagementState createState() => _MedicineManagementState();
}

class _MedicineManagementState extends State<MedicineManagement> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) {
              var cubit = GetMedicalCubit();
              cubit.onGet('');
              return cubit;
            },
          )
        ],
        child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<GetMedicalCubit, GetMedicalState>(
                  builder: (BuildContext context, state) {
                    if (state is GetMedicalLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is GetMedicalFailure) {
                      return Center(child: Text(state.errorMsg));
                    }
                    if (state is GetMedicalSuccess) {
                      return DataTable(
                        columns: _createColumn(),
                        rows: _createRow(state.Medicals, context),
                      );
                    }
                    return const Center(child: Text('Something went wrong'));
                  },
                ),

              ),
            ),
            floatingActionButton:AddMedical()
        ));
  }

  List<DataColumn> _createColumn() {
    return [
      const DataColumn(label: Text('ID')),
      const DataColumn(label: Text('Tên')),
      const DataColumn(label: Text('Đơn vị')),
      const DataColumn(label: Text('Lượng tồn')),
      const DataColumn(label: Text('Hành động')),
    ];
  }

  List<DataRow> _createRow(List<Medicine> medicals, BuildContext context) {
    return medicals.map((medical) {
      return DataRow(
        cells: [
          DataCell(Text(medical.id)),
          DataCell(Text(medical.name)),
          DataCell(Text(medical.unit)),
          DataCell(Text(medical.quantity.toString())),
          DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => showEditMedicalDialog(context, medical),
              ),
              IconButton(
                icon:  Icon(medical.status==0? Icons.delete:Icons.recycling, color: Colors.red),
                onPressed: () => deleteMedical(context, medical.id),
              ),
            ],
          )),
        ],
      );
    }).toList();
  }
}