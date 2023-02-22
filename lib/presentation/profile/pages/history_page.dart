import 'package:flutter/material.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/spaces.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:icare_pro/presentation/core/icare_search_field.dart';
import 'package:icare_pro/presentation/home/widgets/history_item_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          historyString,
          style: boldSize16Text(AppColors.blackColor),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColor.withOpacity(0.25),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              smallHorizontalSizedBox,
              ICareSearchField(
                hintText: 'Search',
                onSubmitted: (value) {},
              ),
              size15VerticalSizedBox,
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
