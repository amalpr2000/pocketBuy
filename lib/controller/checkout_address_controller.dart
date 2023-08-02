import 'package:get/get.dart';
import 'package:pocketbuy/model/address_model.dart';

class CheckoutAddControl extends GetxController {
  AddressModel? address;
  setter({required AddressModel initAddress}) {
    address = initAddress;
    update();
  }
}
