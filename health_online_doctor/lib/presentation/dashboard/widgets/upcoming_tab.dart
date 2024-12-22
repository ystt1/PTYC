import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../prescription/page/prescription_page.dart';
import '../bloc/get_appointment_today_cubit.dart';
import 'list_appointment.dart';


class UpcomingTab extends StatelessWidget {
  const UpcomingTab({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) {
        var cubit = GetAppointmentTodayCubit();
        cubit.getAppointment(1);
        return cubit;
      },
      child: const ListAppointment(type: 1,),
    );
  }

  Widget AppointmentCard(
      BuildContext context, Map<String, String> appointment) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(blurRadius: 4, spreadRadius: 0, offset: Offset(0, 0)),
              ],
              color: Colors.white),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Time: 10h  14/12/2024'), Text('done')],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2, // Tỉ lệ phân chia độ rộng
                    child: Text(
                      'Tên: Phan Quoc Tuan',
                      textAlign: TextAlign.left,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Tuổi: 29',
                      textAlign: TextAlign.center,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Text(
                      'Chẩn đoán: Bị đẹp trai quá mức cho phép',
                      textAlign: TextAlign.right,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
