import 'package:flutter/material.dart';
import 'package:pocketbuy/model/cart_model.dart';

class CheckoutItemTile extends StatelessWidget {
  const CheckoutItemTile({super.key, required this.data});
  final CartModel data;
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: displayHeight * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: displayHeight * 0.1,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(displayHeight * 0.01),
              border: Border.all(color: Colors.grey),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(
                  data.imageLink!,
                ),
              ),
            ),
          ),
          SizedBox(
            width: displayWidth * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.name!, ),
                Text("₹${data.price}/qty",),
             
              ],
            ),
          ),
          Container(
            height: displayHeight * 0.024,
            width: displayWidth * 0.128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(displayWidth * 0.05),
              border: Border.all(),
            ),
            child: Center(
              child: Text(
                '${data.quantity}',
                
              ),
            ),
          )
        ],
      ),
    );
  }
}
