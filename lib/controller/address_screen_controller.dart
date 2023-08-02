import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/model/address_model.dart';

import '../service/auth/wishlist.dart';

class AddressScrnController extends GetxController {
  List<AddressModel> addressList = [];
  int? selectedIndex;
  getAddressList() async {
    List data = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentEmail)
        .collection('address')
        .get()
        .then((value) => value.docs);
    addressList.clear();
    for (var element in data) {
      AddressModel address = AddressModel.fromData(data: element);

      addressList.add(address);
    }
    if (addressList.isNotEmpty) {
      selectedIndex = 0;
    }
    update();
  }

  changeSelected({required int newindex}) {
    selectedIndex = newindex;
    update();
  }
}
