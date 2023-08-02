import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/controller/cart_controller.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';

import 'package:pocketbuy/view/cart/widgets/cart_list_tile.dart';
import 'package:pocketbuy/view/checkout/checkout_screen.dart';

import '../../service/auth/wishlist.dart';
// final cartControllerObj = CartController();

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final CartController cartObj = CartController();
  @override
  Widget build(BuildContext context) {
    // cartControllerObj.getCartList();
    cartObj.getCartList();

    var displayHeight = MediaQuery.of(context).size.height;
    // var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: GetBuilder<CartController>(
          init: cartObj,
          builder: (controller) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: displayHeight * .6,
                child: controller.cartList.isEmpty
                    ? SizedBox(
                        child: Center(
                          child: Text('No items in cart'),
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(controller.cartList[index].name!),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\₹${controller.cartList[index].price!}',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      color: Colors.grey[300],
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              controller.productQtyDec(
                                                  index: index,
                                                  context: context);
                                            },
                                            child: Icon(
                                              Icons.minimize_rounded,
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        '${controller.cartList[index].quantity}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.productQtyInc(
                                            index: index, context: context);
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        color: Colors.grey[300],
                                        child: Icon(
                                          Icons.add,
                                          size: 16,
                                        ),
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
                                      image: NetworkImage(
                                          '${controller.cartList[index].imageLink!}'))),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      titlePadding: EdgeInsets.only(
                                          left: 90, right: 90, top: 20),
                                      title: Text('Are you Sure ?'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              'This will delete the product from cart'),
                                          kHeight20,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text('Cancel')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    controller.productDelete(
                                                        index: index);
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
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                        itemCount: controller.cartList.length),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                // height: 174,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -15),
                      blurRadius: 20,
                      color: Color(0xFFDADADA).withOpacity(0.55),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Total:\n",
                            children: [
                              TextSpan(
                                text: "\₹${controller.totalCartPrice}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 150,
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  primary: Colors.white,
                                  backgroundColor: kPrimaryColor,
                                ),
                                onPressed: () {
                                  Get.to(() => CheckoutScreen(
                                        totalPrice: controller.totalCartPrice,
                                        cartList: controller.cartList,
                                      ));
                                },
                                child: Text(
                                  'Check Out',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
