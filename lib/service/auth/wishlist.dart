import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/utils/snackbar.dart';

final currentEmail = FirebaseAuth.instance.currentUser!.email;

class WishlistService {
  WishlistService();

  Future<void> addToWishlist(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('userSide')
          .doc('wishlist')
          .collection(currentEmail!)
          .doc(productId)
          .set({'productid': productId}).then((value) {
        customSnackbar(
          title: 'Successfully Added',
          msg: 'Product added to wishlist',
          barColor: snackGreen,
        );
      });
      return;
    } on FirebaseException catch (e) {
      customSnackbar(
        title: 'Error',
        msg: '${e.message}',
        barColor: snackred,
      );
      return;
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('userSide')
          .doc('wishlist')
          .collection(currentEmail!)
          .doc(productId)
          .delete()
          .then((value) {
        customSnackbar(
          title: 'Successfully removed',
          msg: 'Product removed from wishlist',
          barColor: Colors.red,
        );
        return;
      });
    } on FirebaseException catch (e) {
      // alertshower(e.message);
      return;
    }
  }
}
