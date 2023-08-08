import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/controller/order_controller.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/model/order_model.dart';
import 'package:pocketbuy/view/cart/cart_screen.dart';
import 'package:pocketbuy/view/orders/orderstatus.dart';

String constimage =
    'https://media.istockphoto.com/id/1138644570/vector/shopping-cart-icon-design-cart-icon-symbol-design.jpg?s=612x612&w=0&k=20&c=_lTGkSkJ6ha8ZNiKD8XWVtLNyTjQ74HCu_c4WFio27g=';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});
  final orderController = OrderScrnController();

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    orderController.getOrderIds();
    return GetBuilder<OrderScrnController>(
        init: orderController,
        builder: (controller) {
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: displayWidth * .38),
                    const Text(
                      'My Orders',
                      style:
                          TextStyle(color: Color(0XFF8B8B8B), fontSize: 18, fontFamily: 'Sniglet'),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        CircleAvatar(backgroundColor: Colors.grey[200]),
                        IconButton(
                            padding: const EdgeInsets.only(bottom: 3, right: 5),
                            onPressed: () {
                              Get.to(() => CartScreen());
                            },
                            icon: const Icon(Icons.shopping_cart_checkout_rounded,
                                color: kSecondaryColor))
                      ],
                    ),
                  ],
                ),
                kHeight10,
                SizedBox(
                  height: displayHeight * .6,
                  child: controller.orderIdlist.isEmpty
                      ? Center(child: Text('No order placed'))
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            var streamMaker = FirebaseFirestore.instance
                                .collection('order')
                                .doc(controller.orderIdlist[index])
                                .snapshots();
                            return StreamBuilder(
                                stream: streamMaker,
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return const Center(
                                      child: Text('data not found'),
                                    );
                                  }
                                  OrderModel orderData = OrderModel.fromMap(snapshot.data);
                                  String imagePath = orderData.cartlist!.length > 1
                                      ? constimage
                                      : orderData.cartlist![0].imageLink!;
                                  return ListTile(
                                    tileColor: Colors.grey[100],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    onTap: () => Get.to(() => OrderDetails(
                                        orderDetails: orderData, orderId: snapshot.data!.id)),
                                    title: Text(
                                      'Order id: ${snapshot.data!.id}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(orderData.orderStatus!,
                                        style: const TextStyle(color: kPrimaryColor)),
                                    leading: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: NetworkImage(imagePath),
                                        ),
                                      ),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.arrow_forward_ios,
                                            color: kSecondaryColor)),
                                  );
                                });
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 15),
                          itemCount: controller.orderIdlist.length),
                )
              ],
            ),
          );
        });
  }
}
