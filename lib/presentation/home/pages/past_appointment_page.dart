import 'package:flutter/material.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/spaces.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:icare_pro/presentation/core/icare_search_field.dart';
import 'package:icare_pro/presentation/home/widgets/history_item_widget.dart';

class PastAppointmentsPage extends StatelessWidget {
  const PastAppointmentsPage({super.key});

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
              ICareSearchField(
                hintText: 'Search',
                onSubmitted: (value) {},
              ),
              mediumVerticalSizedBox,
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  pastAppointmentsString,
                  style: boldSize16Text(AppColors.blackColor),
                ),
              ),
              smallVerticalSizedBox,
              const HistoryItemWidget(
                date: dateOfBirthHintString,
                time: '0600hrs',
                name: fullNameHintString,
              ),
              const HistoryItemWidget(
                date: dateOfBirthHintString,
                time: '0600hrs',
                name: fullNameHintString,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
