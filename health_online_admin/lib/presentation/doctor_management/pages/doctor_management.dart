import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/domain/doctor/entity/doctor_entity.dart';

import 'package:health_online_admin/presentation/Doctor_management/bloc/get_Doctor_state.dart';

import '../bloc/get_doctor_cubit.dart';
import '../widgets/add_doctor.dart';
import '../widgets/delete_doctor.dart';
import '../widgets/edit_doctor.dart';

class DoctorManagement extends StatefulWidget {
  const DoctorManagement({super.key});

  @override
  _DoctorManagementState createState() => _DoctorManagementState();
}

class _DoctorManagementState extends State<DoctorManagement> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) {
              var cubit = GetDoctorCubit();
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
                child: BlocBuilder<GetDoctorCubit, GetDoctorState>(
                  builder: (BuildContext context, state) {
                    if (state is GetDoctorLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is GetDoctorFailure) {
                      return Center(child: Text(state.errorMsg));
                    }
                    if (state is GetDoctorSuccess) {
                      return DataTable(
                        columns: _createColumn(),
                        rows: _createRow(state.doctors, context),
                      );
                    }
                    return const Center(child: Text('Something went wrong'));
                  },
                ),
              ),
            ),
            floatingActionButton: const AddDoctor()));
  }

  List<DataColumn> _createColumn() {
    return [
      const DataColumn(label: Text('ID')),
      const DataColumn(label: Text('Email')),
      const DataColumn(label: Text('Mật khẩu')),
      const DataColumn(label: Text('Tên')),
      const DataColumn(label: Text('Mô tả')),
      const DataColumn(label: Text('Chuyên ngành')),
      const DataColumn(label: Text('Hành động')),
    ];
  }

  List<DataRow> _createRow(List<DoctorEntity> doctors, BuildContext context) {
    return doctors.map((doctor) {
      return DataRow(
        cells: [
          DataCell(Text(doctor.id)),
          DataCell(Text(doctor.email)),
          DataCell(
            SizedBox(
              width: 170,
              child: Text(
                doctor.password,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          DataCell(Text(doctor.name)),
          DataCell( SizedBox(
            width: 200,
            child: Text(
              doctor.description,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.clip,
            ),
          ),),
          DataCell(Text(doctor.specialized)),
          DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => showEditDoctorDialog(context, doctor),
              ),
              IconButton(
                icon: Icon(doctor.status == 0 ? Icons.delete : Icons.recycling,
                    color: Colors.red),
                onPressed: () => deleteDoctor(context, doctor.id),
              ),
            ],
          )),
        ],
      );
    }).toList();
  }
}
