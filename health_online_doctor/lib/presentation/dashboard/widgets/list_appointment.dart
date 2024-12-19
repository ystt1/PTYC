import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/get_appointment_today_cubit.dart';
import '../bloc/get_appointment_today_state.dart';
import 'appointment_card.dart';

class ListAppointment extends StatelessWidget {
  final int type;

  const ListAppointment({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: BlocBuilder<GetAppointmentTodayCubit, GetAppointmentTodayState>(
          builder: (BuildContext context, GetAppointmentTodayState state) {
            if (state is GetAppointmentTodayLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetAppointmentTodayFailure) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is GetAppointmentTodaySuccess) {
              if (state.appointments.isEmpty) {
                return Center(
                  child: Text(type == 0
                      ? "Today is Free"
                      : (type == -1
                          ? "you didn\'n have any appointment"
                          : "you doesn\'t have any appointment in the future yet")),
                );
              }
              return ListView.builder(
                itemCount: state.appointments.length,
                itemBuilder: (context, index) {
                  return AppointmentCard(
                      appointment: state.appointments[index],type: type,);
                },
              );
            }
            return const Center(
              child: Text('Something went wrong'),
            );
          },
        ),
      );
    });
  }
}
