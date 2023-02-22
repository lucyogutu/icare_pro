import 'package:flutter/material.dart';
import 'package:icare_pro/domain/entities/appointment.dart';
import 'package:icare_pro/presentation/core/zero_state_widget.dart';
import 'package:icare_pro/presentation/home/widgets/appointment_list_item_widget.dart';

class UpcomingAppointmentsPage extends StatelessWidget {
  const UpcomingAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Appointment> appointments = [
      Appointment(
        date: DateTime.now(),
        patient: 'John Doe',
      ),
      Appointment(
        date: DateTime.now(),
        patient: 'Lucy Ogutu',
      ),
      Appointment(
        date: DateTime.now(),
        patient: 'Jane Doe',
      ),
      Appointment(
        date: DateTime.now(),
        patient: 'Emily White',
      ),
      Appointment(
        date: DateTime.now(),
        patient: 'James Bond',
      ),
      Appointment(
        date: DateTime.now(),
        patient: 'Alexander',
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (appointments.isNotEmpty) ...[
                ...appointments.map((appointment) {
                  return AppointmentListItemWidget(
                    patientName: appointment.patient,
                    date: appointment.date,
                  );
                }).toList(),
              ] else
                ZeroStateWidget(
                  text: 'No scheduled appointments',
                  onPressed: () => Navigator.of(context).pop(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
