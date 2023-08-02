import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/controller/cart_controller.dart';
import 'package:pocketbuy/controller/wishlist_controller.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';
import 'package:pocketbuy/view/brand_page.dart';
import 'package:pocketbuy/view/cart/cart_screen.dart';
import 'package:pocketbuy/view/product_details.dart';
import 'package:pocketbuy/view/search/search.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final isWishlistObj = Get.put(WishlistController());
  bool a = false;
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayHWidth = MediaQuery.of(context).size.width;
    Widget buildImage(String urlImage, int index) {
      return SizedBox(
        height: displayHeight * .15,
        width: displayHWidth * .9,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: displayHeight * .15,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(urlImage))),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => SearchScreen());
                },
                child: SizedBox(
                  height: 50,
                  width: displayHWidth * .7,
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.search_rounded,
                          color: kSecondaryColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Try search here',
                          style: TextStyle(color: kSecondaryColor),
                        ),
                        SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                    // child: TextFormField(
                    //   onTap: () {
                    //     Get.to(SearchScreen());
                    //   },
                    //   decoration: InputDecoration(
                    //     prefixIcon: const Icon(Icons.search_rounded),
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     contentPadding: const EdgeInsets.all(20),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //       borderSide:
                    //           const BorderSide(color: Colors.white, width: 0.0),
                    //     ),
                    //     labelText: 'Try search here',
                    //     labelStyle: const TextStyle(color: kSecondaryColor),
                    //     border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12)),
                    //   ),
                    // ),
                  ),
                ),
              ),
              SizedBox(
                width: displayHWidth * .077,
              ),
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
              )
            ],
          ),
          kHeight20,
          // Container(
          //   height: displayHeight * .15,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     color: Colors.grey,
          //     // image: DecorationImage(
          //     //     fit: BoxFit.fill,
          //     //     image: AssetImage('assets/images/banner.jpg'))
          //   ),
          //   child:
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('pocketBuy')
                .doc('admin')
                .collection('banners')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CarouselSlider.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = snapshot.data!.docs[index]['imageUrl'];
                    return buildImage(urlImage, index);
                  },
                  options: CarouselOptions(
                    // enlargeCenterPage: true,
                    viewportFraction: .98,
                    height: displayHeight * .15,
                    autoPlay: true,
                  ));
            },
          ),
          // ),
          kHeight10,
          const Text(
            'Popular Brands',
            style: TextStyle(fontSize: 20),
          ),
          kHeight10,
          SizedBox(
            height: displayHeight * .1,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('pocketBuy')
                  .doc('admin')
                  .collection('brands')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () => Get.to(() => BrandPage(
                                title: snapshot.data!.docs[index].id)),
                            child: Container(
                              height: displayHeight * .08,
                              width: displayHeight * .08,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  snapshot.data!.docs[index]['brandImg'],
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          width: displayHeight * .012,
                        ),
                    itemCount: snapshot.data!.docs.length);
              },
            ),
          ),
          kHeight10,
          SizedBox(
            height: displayHeight * 0.43,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('pocketBuy')
                  .doc('admin')
                  .collection('products')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Material(
                        elevation: 7,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ProductDetails(
                                productId: snapshot.data!.docs[index].id));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            // margin: EdgeInsets.all(0),
                            // elevation: 5,
                            height: 100,

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 125,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot.data!
                                              .docs[index]['productImg1']))),
                                ),
                                Text(snapshot.data!.docs[index]['productName']),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '₹ ${snapshot.data!.docs[index]['productPrice']}',
                                      style:
                                          const TextStyle(color: kPrimaryColor),
                                    ),
                                    FutureBuilder(
                                        future: WishlistService().checkWishlist(
                                            productid:
                                                snapshot.data!.docs[index].id),
                                        builder: (context, snapshot1) {
                                          return GetBuilder<WishlistController>(
                                            builder: (controllerobj) => InkWell(
                                              onTap: () {
                                                if (snapshot1.data == true) {
                                                  WishlistService()
                                                      .removeWishlist(
                                                          context: context,
                                                          productid: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id);
                                                } else {
                                                  WishlistService()
                                                      .addToWishlist(
                                                          context: context,
                                                          productid: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id);
                                                }
                                                controllerobj.updateIcon(
                                                    isContain:
                                                        !snapshot1.data!);
                                                a = !snapshot1.data!;
                                              },
                                              child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: a
                                                      ? const Icon(
                                                          Icons
                                                              .favorite_rounded,
                                                          size: 15,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .favorite_outline_rounded,
                                                          size: 15,
                                                        )),
                                            ),
                                          );
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
