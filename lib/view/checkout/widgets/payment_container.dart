import 'package:flutter/material.dart';
import 'package:pocketbuy/controller/payment_controller.dart';
import 'package:pocketbuy/core/colors.dart';

class PaymentContainer extends StatelessWidget {
  const PaymentContainer(
      {super.key,
      required this.value,
      required this.child,
      required this.controller});
  final int value;
  final Widget child;
  final PaymentController controller;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.changeValue(value),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: value == controller.value
                    ? kPrimaryColor
                    : kSecondaryColor),
            borderRadius: BorderRadius.circular(8)),
        child: child,
      ),
    );
  }
}
