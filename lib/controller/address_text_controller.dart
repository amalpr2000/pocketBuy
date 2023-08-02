

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/model/address_model.dart';
import 'package:pocketbuy/service/address_service.dart';

class AddressTextController extends GetxController{
  final TextEditingController localAddressCon = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController districtController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController pinController = TextEditingController();

  final TextEditingController landmark = TextEditingController();

  addressAdding() async{
    AddressModel address = AddressModel(
        localAddress: localAddressCon.text.trim(),
        city: cityController.text.trim(),
        district: districtController.text.trim(),
        state: stateController.text.trim(),
        pincode: pinController.text.trim(),
        landmark: landmark.text.trim()==''?'no landmark':landmark.text.trim());
    await AddressService().addAddress(address: address);
  }
}
