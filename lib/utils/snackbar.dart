import 'package:flutter/material.dart';
import 'package:get/get.dart';

// void snack(BuildContext context, {required String message, required Color color}) {
//   ScaffoldMessenger.of(context)
//     ..removeCurrentSnackBar()
//     ..showSnackBar(SnackBar(
//       duration: Duration(seconds: 1),
//       content: Text(message),
//       backgroundColor: color,
//       elevation: 6,
//       behavior: SnackBarBehavior.floating,
//       margin: EdgeInsets.all(21),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     ));
// }

SnackbarController customSnackbar(
    {required String title, required String msg, required Color barColor, var position}) {
  SnackPosition pos = position ?? SnackPosition.BOTTOM;
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }
  return Get.snackbar(title, msg,
      snackPosition: pos,
      margin: EdgeInsets.all(22),
      backgroundColor: barColor,
      duration: Duration(seconds: 2),
      colorText: Colors.white,
      padding: EdgeInsets.all(10));
}
