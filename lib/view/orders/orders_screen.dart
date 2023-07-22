import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/view/cart/cart_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

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
              'My Orders',
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
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Apple iphone 14 Pro'),
                  subtitle: Text(
                    'Order Placed',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  leading: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/14pro.jpg'))),
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: kSecondaryColor,
                      )),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
              itemCount: 3),
        )
      ],
    ));
  }
}
