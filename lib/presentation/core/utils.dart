import 'package:flutter/material.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:icare_pro/presentation/core/icare_text_button.dart';

// utils.dart, a class holding common methods

// alert dialog for logout and optout options
Future<dynamic> showAlertDialog(BuildContext context, String title,
    String content, VoidCallback yesButton) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ICareTextButton(
            onPressed: () => Navigator.of(context).pop(),
            text: noCancel,
            style: boldSize14Text(AppColors.primaryColor),
          ),
          ICareTextButton(
            onPressed: yesButton,
            text: yesLogout,
            style: boldSize14Text(AppColors.redColor),
          ),
        ],
      );
    },
  );
}
