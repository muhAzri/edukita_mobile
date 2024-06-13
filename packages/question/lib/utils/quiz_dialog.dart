import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showQuizResultDialog({
  required BuildContext context,
  required String title,
  String? desc,
  required DialogType type,
  String? btnText,
  required Function() onOkPressed,
}) {
  AwesomeDialog(
    context: context,
    animType: AnimType.bottomSlide,
    dialogType: type,
    title: title,
    desc: desc,
    dismissOnTouchOutside: false,
    btnOkOnPress: onOkPressed,
    btnOkText: btnText ?? "Lanjut",
  ).show();
}
