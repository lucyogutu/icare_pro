import 'package:flutter/material.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/spaces.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:intl/intl.dart';

class HistoryItemWidget extends StatelessWidget {
  const HistoryItemWidget({
    super.key,
    required this.date,
    required this.time,
    required this.patientFirstName,
    required this.patientLastName,
  });

  final String date;
  final DateTime time;
  final String patientFirstName;
  final String patientLastName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
            color: AppColors.primaryColor.withOpacity(0.25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateString,
                      style: heavySize16Text(AppColors.blackColor),
                    ),
                    Text(
                      timeString,
                      style: heavySize16Text(AppColors.blackColor),
                    ),
                    Text(
                      patientString,
                      style: heavySize16Text(AppColors.blackColor),
                    ),
                  ],
                ),
                smallVerticalSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: normalSize16Text(AppColors.blackColor),
                    ),
                    Text(
                      DateFormat.jm().format(time),
                      style: normalSize16Text(AppColors.blackColor),
                    ),
                    Text(
                      '$patientFirstName $patientLastName',
                      style: normalSize16Text(AppColors.blackColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        smallVerticalSizedBox,
      ],
    );
  }
}
