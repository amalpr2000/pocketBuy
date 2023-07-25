import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

loadingAnimation() {
  Get.dialog(
      Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.transparent,
          child: Center(
            child: LoadingAnimationWidget.waveDots(
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
      barrierDismissible: false);
}
