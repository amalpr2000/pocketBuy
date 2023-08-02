import 'package:flutter/material.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/model/order_model.dart';
import 'package:pocketbuy/view/orders/widgets/itemtile.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.orderDetails, required this.orderId});
  final OrderModel orderDetails;
  final String orderId;
  static const String routename = '/Orderdetails';
  @override
  Widget build(BuildContext context) {
    String payment = orderDetails.israzorpay! ? 'Razorpay' : 'Cash on Delivery';
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: ListView(
        padding: EdgeInsets.all(displayWidth * 0.05),
        children: [
          Row(
            children: [
              const Icon(Icons.shopping_cart_outlined),
              Text('ITEMS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          sizedboxwithheight(displayHeight * 0.008),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: orderDetails.cartlist!.length,
            itemBuilder: (context, index) => CheckoutItemTile(data: orderDetails.cartlist![index]),
            separatorBuilder: (context, index) => const Divider(),
          ),
          sizedboxwithheight(displayHeight * 0.05),
          Text(
            'Order ID: $orderId',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          sizedboxwithheight(displayHeight * 0.008),
          Text(
            'Total Price: ${orderDetails.totalPrice}',
          ),
          sizedboxwithheight(displayHeight * 0.008),
          Text(
            'Payment Method: $payment',
          ),
          sizedboxwithheight(displayHeight * 0.008),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivering Address :',
              ),
              SizedBox(
                width: displayWidth * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${orderDetails.address!.localAddress},',
                    ),
                    Text(
                      '${orderDetails.address!.city},${orderDetails.address!.district},',
                    ),
                    Text(
                      '${orderDetails.address!.state},',
                    ),
                    Text(
                      'Pin:${orderDetails.address!.pincode}',
                    ),
                    orderDetails.address!.landmark != 'no landmark'
                        ? Text(
                            'landmark:${orderDetails.address!.landmark}',
                            overflow: TextOverflow.ellipsis,
                          )
                        : const SizedBox(),
                  ],
                ),
              )
            ],
          ),
          sizedboxwithheight(displayHeight * 0.05),
          OrderTrackerZen(
              tracker_data: tracker(
                  status: orderDetails.orderStatus!,
                  orderdate: orderDetails.orderPlacedDate,
                  shippedDate: orderDetails.shippingDate,
                  outForDeliveryDate: orderDetails.outForDeliveryDate,
                  deliveryDate: orderDetails.deliveryDate))
        ],
      ),
    ));
  }

  List<TrackerData> tracker(
      {required String status,
      required String? orderdate,
      required String? shippedDate,
      required String? outForDeliveryDate,
      required String? deliveryDate}) {
    const List<String> statusList = [
      'Order Placed',
      'Order Shipped',
      'Out For Delivery',
      'Order Delivered',
    ];

    List<String?> dates = [orderdate, shippedDate, outForDeliveryDate, deliveryDate];

    int noOfStage = 0;
    for (int i = 0; i < 4; i++) {
      if (status == statusList[i]) {
        noOfStage = i;
      }
    }
    List<TrackerData> trackerdata = [];
    for (int i = 0; i <= noOfStage; i++) {
      String date = dates[i]!.substring(0, 10);
      String datetTime = dates[i]!.substring(0, 16);
      trackerdata.add(TrackerData(title: statusList[i], date: date, tracker_details: [
        TrackerDetails(title: 'Your ${statusList[i]} on', datetime: datetTime)
      ]));
    }
    return trackerdata;
  }
}
