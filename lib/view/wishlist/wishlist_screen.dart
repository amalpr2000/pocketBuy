import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';
import 'package:pocketbuy/view/cart/cart_screen.dart';
import 'package:pocketbuy/view/wishlist/widgets/wishlist_tile.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: displayWidth * .38,
            ),
            Text(
              'Wishlist',
              style: TextStyle(
                  color: Color(0XFF8B8B8B),
                  fontSize: 18,
                  fontFamily: 'Sniglet'),
            ),
            Spacer(),
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                ),
                IconButton(
                    padding: const EdgeInsets.only(bottom: 3, right: 5),
                    onPressed: () {
                      Get.to(() => CartScreen());
                    },
                    icon: const Icon(
                      Icons.shopping_cart_checkout_rounded,
                      color: kSecondaryColor,
                    ))
              ],
            ),
          ],
        ),
        kHeight10,
        SizedBox(
          height: displayHeight * .6,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('userSide')
                  .doc('wishlist')
                  .collection(currentEmail!)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return WishlistTile(
                          productId: snapshot.data!.docs[index]['productId']);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 15,
                        ),
                    itemCount: snapshot.data!.docs.length);
              }),
        )
      ],
    ));
  }
}
