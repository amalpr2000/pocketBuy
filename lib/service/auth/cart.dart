import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';
import 'package:pocketbuy/utils/snackbar.dart';

class CartService {
  addToCart({required String productid, required int quantity,required BuildContext context}) async {
    final cartList = FirebaseFirestore.instance
        .collection('userSide')
        .doc('cart')
        .collection(currentEmail!)
        .doc(productid)
        .set({'productId': productid, 'quantity': quantity}).then(
            (value) {
              snack(context,
          message: 'Product added to the cart', color: Colors.green);
            });
  }

  Future<bool> checkCart({required String productid}) async {
    final cartList = await FirebaseFirestore.instance
        .collection('userSide')
        .doc('cart')
        .collection(currentEmail!)
        .doc(productid)
        .get();
    return cartList.exists;
  }

  removeCart({required String productid,required BuildContext context}) async {
    FirebaseFirestore.instance
        .collection('userSide')
        .doc('cart')
        .collection(currentEmail!)
        .doc(productid)
        .delete()
        .then((value) {
      snack(context,
          message: 'Product removed from cart', color: Colors.red);
    });
  }
}
