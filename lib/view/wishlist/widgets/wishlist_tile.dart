import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/view/home/home_screen.dart';

class WishlistTile extends StatelessWidget {
  const WishlistTile({super.key, required this.productId});
  final String productId;
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListTile(
            tileColor: Colors.grey[100],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(snapshot.data?['productName']),
            subtitle: Text(
              '₹${snapshot.data!['productPrice']}',
              style: TextStyle(color: kPrimaryColor),
            ),
            leading: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(snapshot.data!['productImg1']))),
            ),
            trailing: IconButton(
                onPressed: () {
                  wishListObj.remove(productId: productId);
                },
                icon: Icon(
                  Icons.favorite_sharp,
                  color: Colors.red,
                )),
          );
        });
  }
}
