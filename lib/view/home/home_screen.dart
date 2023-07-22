import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/view/brand_page.dart';
import 'package:pocketbuy/view/cart/cart_screen.dart';
import 'package:pocketbuy/view/product_details.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final bannerimages = [
    'https://rukminim2.flixcart.com/fk-p-flap/844/140/image/6ddfa25d81e96026.jpg?q=50',
    'https://rukminim2.flixcart.com/fk-p-flap/844/140/image/e47ed5784394da7c.jpg?q=50',
    'https://rukminim2.flixcart.com/fk-p-flap/844/140/image/f3528e0c6093609b.jpg?q=50',
    'https://rukminim2.flixcart.com/fk-p-flap/844/140/image/6df0e2426912c25a.jpg?q=50'
  ];

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayHWidth = MediaQuery.of(context).size.width;
    Widget buildImage(String urlImage, int index) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: displayHeight * .15,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(urlImage))),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: 50,
              width: displayHWidth * .7,
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(12),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 0.0),
                    ),
                    labelText: 'Try search here',
                    labelStyle: const TextStyle(color: kSecondaryColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
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
            log('${snapshot.data!.docs.length}');
            return CarouselSlider.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = snapshot.data!.docs[index]['imageUrl'];
                  return buildImage(urlImage, index);
                },
                options: CarouselOptions(
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
                          onTap: () => Get.to(() => BrandPage()),
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          Get.to(() => ProductDetails());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          // margin: EdgeInsets.all(0),
                          // elevation: 5,
                          // height: 600,

                          child: Column(
                            children: [
                              Container(
                                height: 125,
                                width: 140,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]['productImg']))),
                              ),
                              Text(snapshot.data!.docs[index]['productName']),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '₹ ${snapshot.data!.docs[index]['productPrice']}',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      Icons.favorite_outline_rounded,
                                      size: 15,
                                    ),
                                  )
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
    );
  }
}
