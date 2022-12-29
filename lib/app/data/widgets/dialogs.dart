import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';

myAlertDialog({
  String? title,
  String? message,
  VoidCallback? onCancel,
  VoidCallback? onSubmit,
}) {
  return Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          '$title',
          style: tsPoppins(color: primary, weight: FontWeight.w600, size: 18),
        ),
        content: Text(
          '$message',
          style:
              tsPoppins(color: textDark80, weight: FontWeight.w400, size: 12),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onCancel,
            child: Text("Cancel",
                style: tsPoppins(
                    color: textDark60, weight: FontWeight.w400, size: 14)),
          ),
          TextButton(
            onPressed: onSubmit,
            child: Text("Confirm",
                style: tsPoppins(
                    color: textDark80, weight: FontWeight.w600, size: 14)),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}
