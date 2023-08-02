import 'dart:developer';
import 'package:pocketbuy/model/address_model.dart';
import 'package:pocketbuy/model/cart_model.dart';
import 'package:pocketbuy/model/order_model.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';
import 'package:pocketbuy/service/order_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class RazorPayService {
  RazorPayService();
  final _razorpay = Razorpay();
  final _razorpaykey = 'rzp_test_Sctk8i9aVmO3MA';
  late OrderModel _order;

  //initialization of razorpay
  razorpayInitialize() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

//unique id creator
  String createUuid() {
    const uuid = Uuid();
    return uuid.v4();
  }

//paying the order
  pay(
      {required int totalPrice,
      required List<CartModel> cartList,
      required AddressModel address}) {
    String uniqueId = createUuid();
    String paymentId = currentEmail! + uniqueId;
    String orderDiscription = '${currentEmail}Order';
    Map<String, dynamic> options = {
      'key': _razorpaykey,
      'amount': totalPrice,
      'currency': 'INR',
      'name': 'Pocket Buy',
      'description': orderDiscription,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '7025307719', 'email': 'amalpr2000@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    String date = DateTime.now().toString();
    _order = OrderModel(
        cartlist: cartList,
        paymentId: paymentId,
        discription: orderDiscription,
        israzorpay: true,
        userid: currentEmail,
        address: address,
        orderStatus: 'Order Placed',
        orderPlacedDate: date,
        totalPrice: totalPrice);
    _razorpay.open(options);
  }

  //Payment is success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log('==================successsssssss');
    OrderServices(_order).addOrder();
  }

  //Payment failed to proceed;
  void _handlePaymentError(PaymentFailureResponse response) {
    log('error');
  }

  //wallet payment selected
  void _handleExternalWallet(ExternalWalletResponse response) {}
}
