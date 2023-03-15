import 'package:flutter/material.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/spaces.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/entities/appointment.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:icare_pro/presentation/core/zero_state_widget.dart';
import 'package:icare_pro/presentation/home/widgets/cancel_appointment_list_item.dart';

class CancelAppointmentsPage extends StatelessWidget {
  const CancelAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Appointment> appointments = [
      // Appointment(
      //   date: DateTime.now(),
      //   patient: fullNameHintString,
      // ),
      // Appointment(
      //   date: DateTime.now(),
      //   patient: 'Lucy Ogutu',
      // ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  canceledAppointmentsString,
                  style: boldSize16Text(AppColors.blackColor),
                ),
              ),
              smallVerticalSizedBox,
              if (appointments.isNotEmpty) ...[
                ...appointments.map((appointment) {
                  return CancelAppointmentListItemWidget(
                    patientName: appointment.patient.toString(),
                    date: DateTime.tryParse(appointment.date!)!,
                  );
                }).toList(),
              ] else
                ZeroStateWidget(
                  text: 'No canceled appointments',
                  onPressed: () => Navigator.of(context).pop(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
