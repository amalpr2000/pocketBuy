import 'package:flutter/material.dart';
import 'package:pocketbuy/core/constants.dart';

alertbox({
  required BuildContext context,
  required title,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('sds'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('data'),
          kHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Cancel')),
              ElevatedButton(onPressed: () {}, child: Text('Continue'))
            ],
          )
        ],
      ),
    ),
  );
}
