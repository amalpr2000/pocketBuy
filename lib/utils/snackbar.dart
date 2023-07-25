import 'package:flutter/material.dart';

void snack(BuildContext context,
    {required String message, required Color color}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(message),
      backgroundColor: color,
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(21),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
}
