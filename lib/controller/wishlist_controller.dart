import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';

class WishlistController extends GetxController {
 
  List<String> wishlist = [];

  add({required String productId}) {
    wishlist.add(productId);

    WishlistService().addToWishlist(productId);
    update();
  }

  remove({
    required String productId,
  }) {
    wishlist.remove(productId);

    WishlistService().removeFromWishlist(productId);
    update();
  }

  getwishlist() async {
    wishlist = await FirebaseFirestore.instance
        .collection('userSide')
        .doc('wishlist')
        .collection(currentEmail!)
        .get()
        .then((value) => value.docs.map((element) => element.id).toList());
    update();
  }
}
