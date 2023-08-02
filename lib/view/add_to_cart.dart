import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/controller/quantity_controller.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/model/cart_model.dart';
import 'package:pocketbuy/service/auth/cart.dart';
import 'package:pocketbuy/view/cart/cart_screen.dart';

class AddToCartAlert extends StatelessWidget {
  // required this.productId,

  //  required this.price,
  //  required this.quantity,
  //  required this.name,
  //   required this.imageLink,
  //   required this.totalprice,
  final String productId;
  final String name;
  final String imageLink;
  final String price;

  const AddToCartAlert(
      {super.key,
      required this.productId,
      required this.name,
      required this.imageLink,
      required this.price});

  @override
  Widget build(BuildContext context) {
    int quantity = 0;
    return AlertDialog(
      titlePadding: EdgeInsets.only(left: 60, right: 20, top: 20),
      title: Text('Select the quantity'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<QuantityController>(
            init: QuantityController(),
            builder: (controller) {
              quantity = controller.quantity;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      controller.quantityDecrement();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      color: Colors.grey[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.minimize_rounded,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      '${controller.quantity}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.quantityIncrement();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.add,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          kHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                    // cartControllerObj.quantity.value = 1;
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    var cost = int.tryParse(price) ?? 0;
                    var cartItem = CartModel(
                        productId: productId,
                        price: cost,
                        quantity: quantity,
                        name: name,
                        imageLink: imageLink,
                        totalprice: quantity * cost);
                    CartService().addToCart(cartItem: cartItem);
                    Get.back();
                  },
                  child: Text('Continue'))
            ],
          )
        ],
      ),
    );
  }
}
