import 'package:flutter/material.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/spaces.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:icare_pro/presentation/core/icare_elevated_button.dart';
import 'package:intl/intl.dart';

class CancelAppointmentListItemWidget extends StatelessWidget {
  const CancelAppointmentListItemWidget({
    super.key,
    required this.patientFirstName,
    required this.patientLastName,
    required this.date,
  });

  final String patientFirstName;
  final String patientLastName;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            border: Border.all(
              color: AppColors.primaryColorLight,
            ),
            color: AppColors.primaryColorLight,
          ),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          DateFormat.MMM().format(date),
                          style: boldSize16Text(AppColors.blackColor),
                        ),
                        Text(
                          DateFormat.d().format(date),
                          style: boldSize25Title(AppColors.blackColor),
                        ),
                        Text(
                          DateFormat.E().format(date),
                          style: boldSize16Text(AppColors.blackColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$patientFirstName $patientLastName',
                              style: boldSize18Text(AppColors.blackColor),
                            ),
                            Text(
                              DateFormat.Hm().format(date),
                              style: boldSize16Text(AppColors.blackColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ICareElevatedButton(
                              text: rescheduleString, onPressed: () {}),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        smallVerticalSizedBox,
      ],
    );
  }
}
