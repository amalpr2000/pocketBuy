import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/view/home/home_screen.dart';
import 'package:pocketbuy/view/orders/orders_screen.dart';
import 'package:pocketbuy/view/profile/profile_screen.dart';
import 'package:pocketbuy/view/wishlist/wishlist_screen.dart';

import '../controller/bottom_nav_controller.dart';

class BottomNavBarWidget extends StatelessWidget {
  BottomNavBarWidget({
    super.key,
  });
  BottomNavController bottomNavObj = BottomNavController();
  // final ConnectivityService connectivityService = Get.find();
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(
        () => Container(
          height: displayHeight,
          width: displayWidth,
          child: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(
                    right: displayWidth * .05,
                    left: displayWidth * .05,
                    top: displayWidth * .05),
                child: screens.elementAt(bottomNavObj.currentIndex.value)),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              bottomNavObj.currentIndex.value = value;
            },
            elevation: 2,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline_rounded),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wallet),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: bottomNavObj.currentIndex.value),
      ),
    );
  }
}

List<Widget> screens = [
  HomeScreen(),
  WishlistScreen(),
  OrdersScreen(),
  ProfileScreen()
];
