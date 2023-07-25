import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/view/bottom_nav.dart';

import 'package:pocketbuy/view/log_in/log_in_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    waiting();
    return Scaffold(
      body: Center(
          child: Text(
        'Pocket Buy',
        style: TextStyle(fontSize: 50, color: kPrimaryColor),
      )),
    );
  }

  waiting() async {
    Timer(Duration(seconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.off(LoginScreen());
      } else {
        Get.off(BottomNavBarWidget());
      }
    });
  }
}
