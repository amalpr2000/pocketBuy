import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';

class OrderScrnController extends GetxController { 
  // List<OrderModel> orderList = [];
  List<String> orderIdlist = [];
  getOrderIds() async {
    // orderList.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentEmail)
        .collection('orderdata').get().then((value) async {
      orderIdlist = value.docs.map((doc) => doc.id).toList();
      // for (String orderId in orderIdlist) {
      //   await FirebaseFirestore.instance.collection('order').doc(orderId).get().then((value) {
      //     orderList.add(OrderModel.fromMap(value));
      //   });
      // }
    });
    update();
  }
}
