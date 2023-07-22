import 'package:flutter/material.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                    ),
                    IconButton(
                        padding: const EdgeInsets.only(bottom: 3, right: 5),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_cart_checkout_rounded,
                          color: kSecondaryColor,
                        ))
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 12,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: Hero(
                    tag: "DemoTag",
                    child: Image.asset(productimages[selectedImage]),
                  ),
                ),
              ),
              // SizedBox(height: getProportionateScreenWidth(20)),
              kHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(productimages.length,
                      (index) => buildSmallProductPreview(index)),
                ],
              ),
              kHeight20,
              Material(
                elevation: 20,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  height: displayHeight * 0.445,
                  // margin: EdgeInsets.only(top: 20),
                  // padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight20,
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Apple iphone 14 Pro',
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40)),
                              color: Colors.grey[200],
                            ),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )),
                          ),
                        ],
                      ),
                      kHeight20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'The Apple iPhone 14 Pro Max 5G comes with a 6.7-inch ProMotion technology touchscreen, features Crash Detection ...'),
                              kHeight20,
                              Text(
                                '\$129999',
                                style: TextStyle(
                                    fontSize: 22, color: kPrimaryColor),
                              ),
                              kHeight40,
                              SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: ElevatedButton(
                                      // style: ButtonStyle(backgroundColor: Colors.orange),
                                      onPressed: () {},
                                      child: const Text(
                                        'Add to Cart',
                                        style: TextStyle(color: kwhite),
                                      ))),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 5),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.asset(productimages[index]),
      ),
    );
  }
}

List productimages = [
  'assets/images/14pro.jpg',
  'assets/images/14pro1.jpg',
  'assets/images/14pro2.jpg',
  'assets/images/14pro3.jpg',
  'assets/images/14pro4.jpg'
];
