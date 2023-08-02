import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/model/order_model.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';

class OrderScrnController extends GetxController {
  List<OrderModel> cartlist = [];
  List<String> orderIdlist = [];
  getOrderIds() async {
    cartlist.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentEmail)
        .collection('orderdata').get().then((value) async {
      orderIdlist = value.docs.map((doc) => doc.id).toList();
      for (String orderId in orderIdlist) {
        await FirebaseFirestore.instance.collection('order').doc(orderId).get().then((value) {
          cartlist.add(OrderModel.fromMap(value));
        });
      }
    });
    update();
  }
}
