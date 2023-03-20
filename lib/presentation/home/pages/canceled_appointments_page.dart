import 'package:flutter/material.dart';
import 'package:icare_pro/application/api/api_services.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/spaces.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/entities/appointment.dart';
import 'package:icare_pro/domain/entities/patient.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:icare_pro/presentation/core/zero_state_widget.dart';
import 'package:icare_pro/presentation/home/widgets/cancel_appointment_list_item.dart';

class CancelAppointmentsPage extends StatefulWidget {
  const CancelAppointmentsPage({super.key});

  @override
  State<CancelAppointmentsPage> createState() => _CancelAppointmentsPageState();
}

class _CancelAppointmentsPageState extends State<CancelAppointmentsPage> {
  Future<List<Appointment>>? _appointments;

  @override
  void initState() {
    super.initState();
    _appointments = getCanceledAppointments();
  }

  Future<Patient?> getPatientById(int id) async {
    List<Patient>? patients = await getPatients();
    return patients.where((patient) => patient.id == id).first;
  }

  @override
  Widget build(BuildContext context) {
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
              FutureBuilder(
                future: _appointments,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return const ZeroStateWidget(
                      text: noCanceledAppointmentsString,
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      var appointment = snapshot.data![index];

                      return FutureBuilder(
                        future: getPatientById(appointment.patient!),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          var patient = snapshot.data!;
                          return CancelAppointmentListItemWidget(
                            startTime: DateTime.parse(
                                '${appointment.date!} ${appointment.startTime!}'),
                            patientFirstName: patient.firstName!,
                            patientLastName: patient.lastName!,
                            date: DateTime.tryParse(appointment.date!)!,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
