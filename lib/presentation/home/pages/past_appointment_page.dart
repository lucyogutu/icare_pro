import 'package:flutter/material.dart';
import 'package:icare_pro/application/api/api_services.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/spaces.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/entities/appointment.dart';
import 'package:icare_pro/domain/entities/patient.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:icare_pro/presentation/core/utils.dart';
import 'package:icare_pro/presentation/core/zero_state_widget.dart';
import 'package:icare_pro/presentation/home/widgets/history_item_widget.dart';

class PastAppointmentsPage extends StatefulWidget {
  const PastAppointmentsPage({super.key});

  @override
  State<PastAppointmentsPage> createState() => _PastAppointmentsPageState();
}

class _PastAppointmentsPageState extends State<PastAppointmentsPage> {
  Future<List<Appointment>>? _appointments;

  @override
  void initState() {
    super.initState();
    _appointments = getPastAppointments();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              smallHorizontalSizedBox,
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  pastAppointmentsString,
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
                      text: noPastAppointmentsString,
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
                              child: SizedBox(),
                            );
                          }
                          if (snapshot.hasError) {
                            errorAlert(context);
                          }
                          var patient = snapshot.data!;
                          return HistoryItemWidget(
                            date: appointment.date!,
                            time: DateTime.parse(
                                '${appointment.date!} ${appointment.startTime!}'),
                            patientFirstName: patient.firstName!,
                            patientLastName: patient.lastName!,
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
