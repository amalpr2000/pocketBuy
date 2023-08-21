import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pocketbuy/controller/wishlist_controller.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';

import 'package:pocketbuy/view/cart/cart_screen.dart';
import 'package:pocketbuy/view/home/home_screen.dart';
import 'package:pocketbuy/view/wishlist/widgets/wishlist_tile.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: GetBuilder<WishlistController>(
      init: wishListObj,
      builder: (controller) => Column(
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
                style: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18, fontFamily: 'Sniglet'),
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
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return WishlistTile(productId: controller.wishlist[index]);
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                    ),
                itemCount: controller.wishlist.length),
          )
        ],
      ),
    ));
  }
}
