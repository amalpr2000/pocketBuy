import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/controller/cart_controller.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/model/cart_model.dart';
import 'package:pocketbuy/service/auth/cart.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';
import 'package:pocketbuy/view/add_to_cart.dart';
import 'package:pocketbuy/view/cart/cart_screen.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({super.key, required this.productId});
  String productId;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // int quantity = 1;
  int selectedImage = 1;
  // CartController cartControllerObj = CartController();
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
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
                        onPressed: () {},
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
                  .doc(widget.productId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Hero(
                          tag: "DemoTag",
                          child: Image.network(
                              snapshot.data!['productImg$selectedImage']),
                        ),
                      ),
                    ),
                    // SizedBox(height: getProportionateScreenWidth(20)),
                    kHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                            3, (index) => buildSmallProductPreview(index)),
                      ],
                    ),
                    kHeight20,
                    Material(
                      elevation: 20,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      child: Container(
                        height: displayHeight * 0.445,
                        // margin: EdgeInsets.only(top: 20),
                        // padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kHeight20,
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  snapshot.data!['productName'],
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Container(
                                  height: 40,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomLeft: Radius.circular(40)),
                                    color: Colors.grey[200],
                                  ),
                                  child: FutureBuilder(
                                    future: WishlistService().checkWishlist(
                                        productid: snapshot.data!.id),
                                    builder: (context, snapshot1) => IconButton(
                                        onPressed: () {
                                          if (snapshot1.data == true) {
                                            WishlistService().removeWishlist(
                                                context: context,
                                                productid: snapshot.data!.id);
                                          } else {
                                            WishlistService().addToWishlist(
                                                context: context,
                                                productid: snapshot.data!.id);
                                          }
                                        },
                                        icon: snapshot1.data ?? false
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : Icon(
                                                Icons.favorite,
                                                color: Colors.white,
                                              )),
                                  ),
                                ),
                              ],
                            ),
                            kHeight20,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!['productDescription'],
                                      maxLines: 6,
                                    ),
                                    kHeight20,
                                    Text(
                                      '\₹${snapshot.data!['productPrice']}',
                                      style: TextStyle(
                                          fontSize: 22, color: kPrimaryColor),
                                    ),
                                    kHeight40,
                                    SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: ElevatedButton(
                                            // style: ButtonStyle(backgroundColor: Colors.orange),
                                            onPressed: () {
                                              var data = snapshot.data!;
                                              showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    AddToCartAlert(
                                                        productId: data.id,
                                                        name:
                                                            data['productName'],
                                                        imageLink:
                                                            data['productImg1'],
                                                        price: data[
                                                            'productPrice']),
                                              );
                                            },
                                            child: const Text(
                                              'Add to Cart',
                                              style: TextStyle(color: kwhite),
                                            ))),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
        ));
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index + 1;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 5),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor
                  .withOpacity(selectedImage == index + 1 ? 1 : 0)),
        ),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('pocketBuy')
                .doc('admin')
                .collection('products')
                .doc(widget.productId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Image.network(snapshot.data!['productImg${index + 1}']);
            }),
      ),
    );
  }
}

List productimages = [
  'assets/images/14pro.jpg',
  'assets/images/14pro1.jpg',
  'assets/images/14pro2.jpg',
  'assets/images/14pro3.jpg',
  'assets/images/14pro4.jpg'
];
