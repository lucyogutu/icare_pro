import 'package:flutter/material.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:icare_pro/presentation/core/icare_text_button.dart';

// utils.dart, a class holding common methods

// alert dialog for logout and optout options
Future<dynamic> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback yesButton,
  required String buttonText,
}) {
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
            text: buttonText,
            style: boldSize14Text(AppColors.redColor),
          ),
        ],
      );
    },
  );
}

// error alert for handling futures
void errorAlert(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(errorString),
            content: const Text(errorOccurredString),
            actions: [
              ICareTextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: okString,
                style: boldSize14Text(AppColors.primaryColor),
              ),
            ],
          );
        });
  });
}
