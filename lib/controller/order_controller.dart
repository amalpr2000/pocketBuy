import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';

class OrderScrnController extends GetxController {
  List<String> orderIdlist = [];
  getOrderIds() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentEmail)
        .collection('orderdata')
        .orderBy("orderPlacedDate", descending: true)
        .get()
        .then((value) async {
      orderIdlist = value.docs.map((doc) => doc.id).toList();
    });
    update();
  }
}
