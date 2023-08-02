import 'package:get/get.dart';

class PaymentController extends GetxController {
  int value = 0;
  PaymentController({required int initialValue}):value=initialValue;
  changeValue(int selected) {
    value = selected;
    update();
  }
}
