import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocketbuy/model/cart_model.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';

class CartService {
  CartService();
  addToCart({required CartModel cartItem}) async {
    try {
      FirebaseFirestore.instance
          .collection('userSide')
          .doc('cart')
          .collection(currentEmail!)
          .doc(cartItem.productId)
          .set(cartItem.toMap(), SetOptions(merge: true)).then((value) {});
    } on FirebaseException catch (e) {
      log(e.message ?? '');
    }
  }

  updateCartItem({
    required String productId,
    required int updateQty,required int price
  }) {
    try {
      FirebaseFirestore.instance
          .collection('userSide')
          .doc('cart')
          .collection(currentEmail!)
          .doc(productId)
          .set({
        'quantity': updateQty,
        'totalPrice': price
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }

  deleteCartItem({required String productId}) async {
    await FirebaseFirestore.instance
        .collection('userSide')
        .doc('cart')
        .collection(currentEmail!)
        .doc(productId)
        .delete();
  }
}
