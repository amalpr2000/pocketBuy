import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/controller/checkout_address_controller.dart';
import 'package:pocketbuy/controller/payment_controller.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/model/cart_model.dart';
import 'package:pocketbuy/model/order_model.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';
import 'package:pocketbuy/service/order_service.dart';
import 'package:pocketbuy/service/razorpay/razorpay.dart';
import 'package:pocketbuy/view/address/address_screen.dart';
import 'package:pocketbuy/view/checkout/widgets/payment_container.dart';

CheckoutAddControl checkoutAddControl = CheckoutAddControl();

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key, required this.cartList, required this.totalPrice});
  final List<CartModel> cartList;
  final int totalPrice;
  final RazorPayService razorPayService = RazorPayService();
  @override
  Widget build(BuildContext context) {
    PaymentController paymentController = PaymentController(initialValue: 0);
    razorPayService.razorpayInitialize();
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
              
              children: [
                kHeight20,
                Text('Select delievery Address'),
                kHeight20,
                InkWell(
                  onTap: () {
                    Get.to(() => AddressScrn());
                  },
                  child: Container(
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
                ),
                kHeight20,
                kHeight10,
                Text('Select delievery Address'),
                kHeight20,
                Container(
                    padding: EdgeInsets.all(20),
                    height: displayHeight * 0.19,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kSecondaryColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: GetBuilder<CheckoutAddControl>(
                        init: checkoutAddControl,
                        builder: (controller) {
                          checkoutAddControl = controller;
                          return controller.address == null
                              ? Center(child: Text('Please add an address'))
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.address!.localAddress),
                                    Text(controller.address!.city),
                                    Text(
                                      controller.address!.district,
                                      style: TextStyle(color: kSecondaryColor),
                                    ),
                                    Text(
                                      controller.address!.state,
                                      style: TextStyle(color: kSecondaryColor),
                                    ),
                                    Text(
                                      controller.address!.pincode,
                                      style: TextStyle(color: kSecondaryColor),
                                    ),
                                    Text(
                                      controller.address!.landmark,
                                      style: TextStyle(color: kSecondaryColor),
                                    ),
                                  ],
                                );
                        })),
                kHeight40,
                Text('Select Payment Methods'),
                kHeight20,
                GetBuilder<PaymentController>(
                  init: paymentController,
                  builder: (controller) {
                    paymentController = controller;
                    return Column(
                      children: [
                        PaymentContainer(
                          controller: paymentController,
                          value: 0,
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
                        kHeight20,
                        PaymentContainer(
                            controller: paymentController,
                            value: 1,
                            child: Image.network(
                              'https://cdn.iconscout.com/icon/free/png-256/free-razorpay-1649771-1399875.png',
                              errorBuilder: (context, error, stackTrace) => SizedBox(),
                            )),
                      ],
                    );
                  },
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
                                  text: "₹$totalPrice",
                                  style: TextStyle(fontSize: 16, color: Colors.black),
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
                                    orderPlacer(value: paymentController.value);
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

  orderPlacer({required int value}) {
    if (checkoutAddControl.address != null) {
      if (value == 1) {
        razorPayService.pay(
            totalPrice: totalPrice, address: checkoutAddControl.address!, cartList: cartList);
      } else {
        String date = DateTime.now().toString();
        OrderModel orderData = OrderModel(
            cartlist: cartList,
            paymentId: 'COD',
            discription: '${currentEmail}Order',
            address: checkoutAddControl.address!,
            israzorpay: false,
            userid: currentEmail,
            totalPrice: totalPrice,
            orderPlacedDate: date,
            orderStatus: 'Order Placed');
        OrderServices(orderData).addOrder();
      }
    }
  }
}
