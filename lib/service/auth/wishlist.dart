// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketbuy/utils/snackbar.dart';

final currentEmail = FirebaseAuth.instance.currentUser!.email;

// class WishlistService {
//   addToWishlist({required String productid,required BuildContext context}) async {
//     final wishlist = FirebaseFirestore.instance
//         .collection('userSide')
//         .doc('wishlist')
//         .collection(currentEmail!)
//         .doc(productid)
//         .set({'productId': productid}).then(
//             (value) {
//               snack(context,
//           message: 'Product added to the wishlist', color: Colors.green);
//             });
//   }

//   Future<bool> checkWishlist({required String productid}) async {
//     final wishlist = await FirebaseFirestore.instance
//         .collection('userSide')
//         .doc('wishlist')
//         .collection(currentEmail!)
//         .doc(productid)
//         .get();
//     return wishlist.exists;
//   }

//   removeWishlist(
//       {required String productid, required BuildContext context}) async {
//     await FirebaseFirestore.instance
//         .collection('userSide')
//         .doc('wishlist')
//         .collection(currentEmail!)
//         .doc(productid)
//         .delete()
//         .then((value) {
//       // if (Get.isSnackbarOpen) {
//       //   Get.closeCurrentSnackbar();
//       // }
//       snack(context,
//           message: 'Product removed from the wishlist', color: Colors.red);
//       // Get.snackbar('Success', 'Product removed from wishlist');
//     });
//   }
// }

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
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(const SnackBar(content: Text('Successfully added')));
      });
      return;
    } on FirebaseException catch (e) {
      // alertshower(e.message);
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
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(const SnackBar(content: Text('Removed from wishlist')));
        return;
      });
    } on FirebaseException catch (e) {
      // alertshower(e.message);
      return;
    }
  }
}
