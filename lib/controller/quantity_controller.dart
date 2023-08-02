import 'package:get/get.dart';

class QuantityController extends GetxController {
  int quantity = 1;
  quantityIncrement() {
    quantity++;
    update();
  }

  quantityDecrement() {
    if (quantity > 1) {
      quantity--;
    }
    update();
  }
}
