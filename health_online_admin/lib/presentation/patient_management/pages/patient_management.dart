import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_admin/common/bloc/button/button_state.dart';
import 'package:health_online_admin/common/bloc/button/button_state_cubit.dart';
import 'package:health_online_admin/data/patient/models/user_model_createReq.dart';
import 'package:health_online_admin/domain/patient/usecase/add_patient_usecase.dart';
import 'package:health_online_admin/presentation/patient_management/bloc/get_patient_cubit.dart';
import 'package:health_online_admin/presentation/patient_management/bloc/get_patient_state.dart';
import 'package:health_online_admin/presentation/patient_management/widgets/add_patient.dart';
import '../../../domain/patient/entity/patient_entity.dart';
import '../widgets/delete_patient.dart';
import '../widgets/edit_patient.dart';

class PatientManagement extends StatefulWidget {
  const PatientManagement({super.key});

  @override
  _PatientManagementState createState() => _PatientManagementState();
}

class _PatientManagementState extends State<PatientManagement> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) {
              var cubit = GetPatientCubit();
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
              child: BlocBuilder<GetPatientCubit, GetPatientState>(
                builder: (BuildContext context, state) {
                  if (state is GetPatientLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is GetPatientFailure) {
                    return Center(child: Text(state.errorMsg));
                  }
                  if (state is GetPatientSuccess) {
                    return DataTable(
                      columns: _createColumn(),
                      rows: _createRow(state.patients, context),
                    );
                  }
                  return const Center(child: Text('Something went wrong'));
                },
              ),
            
            ),
          ),
          floatingActionButton:const AddPatient()
        ));
  }

  List<DataColumn> _createColumn() {
    return [
      const DataColumn(label: Text('ID')),
      const DataColumn(label: Text('Email')),
      const DataColumn(label: Text('Mật khẩu')),
      const DataColumn(label: Text('Tên')),
      const DataColumn(label: Text('Số điện thoại')),
      const DataColumn(label: Text('Hành động')),
    ];
  }

  List<DataRow> _createRow(List<Patient> patients, BuildContext context) {
    return patients.map((patient) {
      return DataRow(
        cells: [
          DataCell(Text(patient.id)),
          DataCell(Text(patient.email)),
          DataCell(
            SizedBox(
              width: 370,
              child: Text(
                patient.password,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          DataCell(Text(patient.name)),
          DataCell(Text(patient.phone)),
          DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => showEditPatientDialog(context, patient),
              ),
              IconButton(
                icon:  Icon(patient.status==0? Icons.delete:Icons.recycling, color: Colors.red),
                onPressed: () => deletePatient(context, patient.id),
              ),
            ],
          )),
        ],
      );
    }).toList();
  }



}
