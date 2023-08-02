import 'dart:developer';

import 'package:get/get.dart';

class WishlistController extends GetxController {
  bool isWishlistUpdated = true;

  updateIcon({required bool isContain}) {
    isWishlistUpdated = isContain;
    update();
    log('whislist called');
  }
}
