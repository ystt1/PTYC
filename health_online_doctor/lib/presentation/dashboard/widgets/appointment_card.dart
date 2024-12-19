import 'package:flutter/material.dart';
import 'package:health_online_doctor/core/app_constant.dart';
import 'package:health_online_doctor/domain/appointment/entity/appointment_entity.dart';
import 'package:health_online_doctor/presentation/prescription/page/old_prescription_page.dart';

import '../../prescription/page/prescription_page.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentEntity appointment;
  final int type;

  const AppointmentCard(
      {super.key, required this.appointment, required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(appointment.status==0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PrescriptionPage(appointment),
            ),
          );
        }
        if(appointment.status==1)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OldPrescriptionPage(appointment: appointment,),
              ),
            );
          }
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Time: ${AppConstant.time[appointment.hourBooking]}  ${appointment.dayBooking}'),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 5),
                      decoration: BoxDecoration(
                          color: appointment.status == 1
                              ? Colors.green
                              : (type == -1 ? Colors.red : Colors.orange)),
                      child: Text(
                        appointment.status == 1
                            ? 'done'
                            : (type == -1 ? 'late' : 'waiting'),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Tên: ${appointment.victimName}',
                      textAlign: TextAlign.left,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Tuổi: ${appointment.age}',
                      textAlign: TextAlign.center,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Mô tả: ${appointment.description}',
                      textAlign: TextAlign.left,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Visibility(
                      visible: appointment.status == 1,
                      child: const Text(
                        'Chẩn đoán: Bị đẹp trai quá mức cho phép',
                        textAlign: TextAlign.right,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
