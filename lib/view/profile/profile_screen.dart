import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/service/auth/authentication.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';
import 'package:pocketbuy/utils/snackbar.dart';
import 'package:pocketbuy/view/cart/cart_screen.dart';
import 'package:pocketbuy/view/log_in/log_in_screen.dart';
import 'package:pocketbuy/view/my_account/my_account.dart';
import 'package:pocketbuy/view/settings/settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              'Profile',
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
        kHeight20,
        CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('assets/images/avatar.jpg'),
        ),
        kHeight10,
        Text(
          currentEmail!,
          style: TextStyle(fontSize: 22, color: kSecondaryColor),
        ),
        kHeight20,
        SizedBox(
          height: displayHeight * .3,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    if (index == 0) {
                      Get.to(() => MyAccount());
                    }
                    if (index == 1) {
                      Get.to(() => SettingScreen());
                    }
                    if (index == 2) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          titlePadding: EdgeInsets.only(left: 90, right: 90, top: 20),
                          title: Text('Are you Sure ?'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Do you want to logout'),
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
                                      onPressed: () async {
                                        Get.back();

                                        await Authentication().signOut();

                                        customSnackbar(
                                            title: 'Logout',
                                            msg: 'Logged out Successfully',
                                            barColor: snackred);
                                        Get.offAll(() => LoginScreen());
                                      },
                                      child: Text('Continue'))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  tileColor: Colors.grey[100],
                  title: Text(menuTitle[index]),
                  leading: Icon(
                    menuIcon[index],
                    size: 30,
                    color: kPrimaryColor,
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

List menuTitle = ['My Account', 'Settings', 'Log Out'];
List menuIcon = [Icons.person, Icons.settings, Icons.logout_rounded];
