import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/model/order_model.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';
import 'package:pocketbuy/view/cart/order_sucess.dart';

class OrderServices {
  final OrderModel _orderData;
  OrderServices(this._orderData);
  addOrder() async {
    try {
      String date = DateTime.now().toString();
      await FirebaseFirestore.instance
          .collection('order')
          .add(_orderData.toMap())
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentEmail)
            .collection('orderdata')
            .doc(value.id)
            .set({
          'value.id': value.id,
          'orderStatus': 'Order Placed',
          'orderPlacedDate': date
        }).then((value) {
          Get.to(() => OrderSuccess());
        });
      });
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }
}
