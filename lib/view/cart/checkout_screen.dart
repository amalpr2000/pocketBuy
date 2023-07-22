import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/view/cart/order_sucess.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('Checkout'),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select delievery Address'),
                kHeight10,
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: kSecondaryColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Add New Address')
                    ],
                  ),
                ),
                kHeight10,
                Container(
                    padding: EdgeInsets.all(20),
                    height: displayHeight * 0.17,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kSecondaryColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amal P R'),
                        Text('+91-7025307719'),
                        Text(
                          'Abcd(H),North Paravur, Ernakulam \nKerala\nPincode : 683594',
                          style: TextStyle(color: kSecondaryColor),
                        ),
                      ],
                    )),
                kHeight10,
                Container(
                    padding: EdgeInsets.all(20),
                    height: displayHeight * 0.17,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amal P R'),
                        Text('+91-7025307719'),
                        Text(
                          'Abcd(H),North Paravur, Ernakulam \nKerala\nPincode : 683594',
                          style: TextStyle(color: kSecondaryColor),
                        ),
                      ],
                    )),
                kHeight20,
                Text('Select Payment Methods'),
                kHeight10,
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.money),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Cash On Delievery')
                    ],
                  ),
                ),
                kHeight10,
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: kSecondaryColor),
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                              'https://cdn.iconscout.com/icon/free/png-256/free-razorpay-1649771-1399875.png'))),

                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Icon(Icons.money),
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     Text('Cash On Delievery')
                  //   ],
                  // ),
                ),
                Spacer(),
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
                                  text: "\$389999",
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    primary: Colors.white,
                                    backgroundColor: kPrimaryColor,
                                  ),
                                  onPressed: () {
                                    Get.to(() => OrderSuccess());
                                  },
                                  child: Text(
                                    'Place Order',
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
            )));
  }
}
