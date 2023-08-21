import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/controller/wishlist_controller.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/view/cart/cart_screen.dart';
import 'package:pocketbuy/view/home/home_screen.dart';

class BrandPage extends StatelessWidget {
  BrandPage({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayHWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text(title),
          centerTitle: true,
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
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
            SizedBox(
              width: 12,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('pocketBuy')
                .doc('admin')
                .collection('products')
                .where('productBrand', isEqualTo: title)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return snapshot.data!.docs.isEmpty
                  ? Center(
                      child: Text('No brand Product available'),
                    )
                  : GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 180),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Material(
                            elevation: 7,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 125,
                                      width: 140,
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  snapshot.data!.docs[index]['productImg1']))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Text(snapshot.data!.docs[index]['productName']),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        '₹ ${snapshot.data!.docs[index]['productPrice']}',
                                        style: const TextStyle(color: kPrimaryColor),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          if (wishListObj.wishlist
                                              .contains(snapshot.data!.docs[index].id)) {
                                            wishListObj.remove(
                                                productId: snapshot.data!.docs[index].id);
                                          } else {
                                            wishListObj.add(
                                                productId: snapshot.data!.docs[index].id);
                                          }
                                        },
                                        child: GetBuilder<WishlistController>(
                                          init: wishListObj,
                                          builder: (controller) {
                                            wishListObj = controller;
                                            return Icon(
                                              wishListObj.wishlist
                                                      .contains(snapshot.data!.docs[index].id)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              size: 28,
                                              color: Colors.red,
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ));
  }
}
