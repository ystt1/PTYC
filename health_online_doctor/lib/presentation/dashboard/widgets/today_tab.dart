import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_doctor/domain/appointment/entity/appointment_entity.dart';
import 'package:health_online_doctor/presentation/dashboard/bloc/get_appointment_today_cubit.dart';
import 'package:health_online_doctor/presentation/dashboard/bloc/get_appointment_today_state.dart';
import 'package:health_online_doctor/presentation/dashboard/widgets/list_appointment.dart';

import '../../prescription/page/prescription_page.dart';

class TodayAppointmentsTab extends StatelessWidget {
  const TodayAppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) {
          var cubit = GetAppointmentTodayCubit();
          cubit.getAppointment(0);
          return cubit;
        },
        child: const ListAppointment(type: 0,),
    );
  }

}
