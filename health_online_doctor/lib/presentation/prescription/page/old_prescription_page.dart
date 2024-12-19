import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_doctor/core/user_storage.dart';
import 'package:health_online_doctor/domain/appointment/entity/appointment_entity.dart';


import '../../../core/app_colors.dart';
import '../../../domain/prescription/entity/medicine_entity.dart';
import '../bloc/get_prescription_cubit.dart';
import '../bloc/get_prescription_state.dart';

class OldPrescriptionPage extends StatelessWidget {
  final AppointmentEntity appointment;

  const OldPrescriptionPage({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text(
          'Đơn thuốc',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) {
            var cubit = GetPrescriptionCubit();
            cubit.onLoading(appointment.id);
            return cubit;
          }),

        ],
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 400,vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: CupertinoColors.systemGrey4,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 8, offset: Offset(0, 4))
                ]),
            child: BlocBuilder<GetPrescriptionCubit, GetPrescriptionState>(
              builder: (BuildContext context, GetPrescriptionState state) {
                if (state is GetPrescriptionStateSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        _doctor(context),
                        _date(context),
                      ],),


                      const SizedBox(
                        height: 10,
                      ),
                      _diagnosis(context, state.prescriptionEntity.diagnosis),
                      const SizedBox(
                        height: 10,
                      ),
                      _note(context, state.prescriptionEntity.note),
                      const SizedBox(
                        height: 10,
                      ),
                      _patientInfor(context),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _medicalAndNumber(context),
                      const SizedBox(
                        height: 10,
                      ),
                      _listMedical(context, state.prescriptionEntity.medicines),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }
                if (state is GetPrescriptionStateFailure) {
                  return Center(
                    child: Text(state.errorMsg),
                  );
                }
                if (state is GetPrescriptionStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: Text("Page not found"),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _date(BuildContext context) {
    return Text('Ngày khám: ${appointment.dayBooking}');
  }

  Widget _doctor(BuildContext context) {
    return Text('Bác sĩ: ${UserStorage.getFullName()}');
  }

  Widget _diagnosis(BuildContext context, String diagnosis) {
    return Text('Chẩn đoán: $diagnosis');
  }

  Widget _note(BuildContext context, String note) {
    return Text('Ghi chú: $note');
  }

  Widget _patientInfor(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Bệnh nhân: ${appointment.victimName}'),
        Text('Tuổi: ${appointment.age.toString()}'),
      ],
    );
  }

  Widget _medicalAndNumber(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Thuốc'),
        Text('Số lượng'),
      ],
    );
  }

  Widget _listMedical(BuildContext context, List<MedicineEntity> medicines) {
    return Expanded(
      child: ListView.builder(
          itemCount: medicines.length,
          itemBuilder: (context, index) {
            return _medicalCard(index + 1, medicines[index]);
          }),
    );
  }

  Widget _medicalCard(int index, MedicineEntity medicine) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                index.toString() + '. ${medicine.name}',
                style: const TextStyle(fontSize: 18),
              ),
              Text('${medicine.quantity}  ${medicine.unit}',
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
          Text(medicine.dosage, style: const TextStyle(fontSize: 14))
        ],
      ),
    );
  }

}
