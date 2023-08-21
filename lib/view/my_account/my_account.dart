import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocketbuy/core/colors.dart';

import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';
import 'package:pocketbuy/view/my_account/widgets/user_data_box.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    const String backgroundImage =
        'https://firebasestorage.googleapis.com/v0/b/pocketbuy-a1375.appspot.com/o/files%2Favatar.jpg?alt=media&token=224bb585-d729-4609-a309-9502f4508b36';
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text('My Account'),
          centerTitle: true,
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              width: 12,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').doc(currentEmail).snapshots(),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      SizedBox(
                        height: displayHeight * 0.28,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            radius: displayHeight * 0.09,
                            backgroundImage: NetworkImage(snapshot.data?['image'] == 'Not added'
                                ? backgroundImage
                                : snapshot.data?['image']),
                            child: Center(
                              child: snapshot.data!['image'] == null
                                  ? Text(
                                      snapshot.data!['name'][0],
                                      style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                        ),
                      ),
                      kHeight10,
                      Text(
                        snapshot.data!['name'] as String,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      sizedboxwithheight(30),
                      UserDataBox(
                          title: 'Name',
                          data: snapshot.data?['name'] ?? '',
                          isName: true,
                          ctx: context),
                      UserDataBox(
                          title: 'Email',
                          data: snapshot.data?['email'] ?? '',
                          isEmail: true,
                          ctx: context),
                      UserDataBox(
                          title: 'Phone',
                          data: snapshot.data?['phone'] ?? '',
                          isPhone: true,
                          ctx: context),
                      kHeight20,
                    ],
                  );
                }),
          ),
        ));
  }
}
