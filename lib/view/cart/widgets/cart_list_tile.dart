import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/controller/cart_controller.dart';

import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/service/auth/cart.dart';

class CartListTile extends StatelessWidget {
   CartListTile(
      {super.key, required this.productId, required this.quantity});
  final String productId;
  final int quantity;
  // final cartObj=CartController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('pocketBuy')
            .doc('admin')
            .collection('products')
            .doc(productId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          return ListTile(
            title: Text(snapshot.data?['productName']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${snapshot.data!['productPrice']}',
                  style: TextStyle(color: kPrimaryColor),
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      color: Colors.grey[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.minimize_rounded,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        '$quantity',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.add,
                        size: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
            leading: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(snapshot.data!['productImg1']))),
            ),
            trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      titlePadding:
                          EdgeInsets.only(left: 90, right: 90, top: 20),
                      title: Text('Are you Sure ?'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('This will delete the product from cart'),
                          kHeight20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('Cancel')),
                              ElevatedButton(
                                  onPressed: () {
                                    // cartObj.removeCart(
                                    //     context: context,
                                    //     productid: snapshot.data!.id);
                                    Get.back();
                                  },
                                  child: Text('Continue'))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.delete_outline_rounded,
                  // color: Colors.red,
                )),
          );
        });
  }
}
