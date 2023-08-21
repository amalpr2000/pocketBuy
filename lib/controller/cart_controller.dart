import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/model/cart_model.dart';
import 'package:pocketbuy/service/auth/cart.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';
import 'package:pocketbuy/utils/snackbar.dart';

class CartController extends GetxController {
  //Cart list
  List<CartModel> cartList = [];
  int totalCartPrice = 0;

  //fetching data from cart databases
  getCartList() async {
    List data = await FirebaseFirestore.instance
        .collection('userSide')
        .doc('cart')
        .collection(currentEmail!)
        .get()
        .then((value) => value.docs);
    totalCartPrice = 0;
    cartList.clear();
    for (var element in data) {
      CartModel cartItem = CartModel.fromData(data: element);
      totalCartPrice += (cartItem.price! * cartItem.quantity!);
      cartList.add(cartItem);
    }
    log('${cartList.length}');
    update();
  }

  //cart product quantity increasing
  productQtyInc({required int index, required BuildContext context}) {
    CartModel data = cartList[index];
    data.quantity = data.quantity! + 1;
    data.totalprice = data.totalprice! + data.price!;
    totalCartPrice += data.price!;
    update();
    CartService()
        .updateCartItem(productId: data.productId!, updateQty: data.quantity!, price: data.price!);
  }

  // cart product quantity decreasing
  productQtyDec({required int index, required BuildContext context}) {
    CartModel data = cartList[index];

    data.quantity = data.quantity! - 1;
    data.totalprice = data.totalprice! - data.price!;
    totalCartPrice -= data.price!;
    update();
    CartService()
        .updateCartItem(productId: data.productId!, updateQty: data.quantity!, price: data.price!);

  }

  //deleting product from cart
  productDelete({required int index}) {
    CartModel data = cartList[index];
    CartService().deleteCartItem(productId: data.productId!);
    totalCartPrice -= cartList[index].totalprice!;
    cartList.removeAt(index);

    update();
  }
}
