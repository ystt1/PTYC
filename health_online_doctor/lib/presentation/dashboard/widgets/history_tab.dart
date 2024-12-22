import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/get_appointment_today_cubit.dart';
import 'list_appointment.dart';



class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        var cubit = GetAppointmentTodayCubit();
        cubit.getAppointment(-1);
        return cubit;
      },
      child: const ListAppointment(type:-1),
    );
  }
}
