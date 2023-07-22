import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/view/bottom_nav.dart';
import 'package:pocketbuy/view/home/home_screen.dart';
import 'package:pocketbuy/view/orders/orders_screen.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 100,
            backgroundColor: Colors.orangeAccent[100],
            child: CircleAvatar(
              radius: 80,
              backgroundColor: kPrimaryColor,
              child: Icon(
                Icons.check_circle_outline_rounded,
                size: 100,
                color: Colors.orangeAccent[100],
              ),
            ),
          ),
          kHeight40,
          SizedBox(
            width: double.infinity,
          ),
          Text('Order placed successfully!'),
          kHeight10,
          Text(
            'Congratulation! Your order has been placed.',
            style: TextStyle(color: kSecondaryColor),
          ),
          kHeight20,
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          // style: ButtonStyle(backgroundColor: Colors.orange),
                          onPressed: () {
                            Get.to(() => BottomNavBarWidget());
                          },
                          child: const Text(
                            'Track Order',
                            style: TextStyle(color: kwhite),
                          ))),
                  kHeight20,
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          // style: ButtonStyle(backgroundColor: Colors.orange),
                          onPressed: () {
                            Get.to(() => BottomNavBarWidget());
                          },
                          child: const Text(
                            'Continue Shopping',
                            style: TextStyle(color: kwhite),
                          ))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
