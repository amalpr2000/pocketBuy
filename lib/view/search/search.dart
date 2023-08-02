import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/controller/search_controller.dart';

import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/view/product_details.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final searchText = SearchController();

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayHWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: displayHWidth * .035,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back)),
                  Spacer(),
                  SizedBox(
                    height: 50,
                    width: displayHWidth * .75,
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        onChanged: (value) {
                          searchText.search(value);
                        },
                        controller: searchText.searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search_rounded),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.0),
                          ),
                          labelText: 'Try search here',
                          labelStyle: const TextStyle(color: kSecondaryColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: displayHWidth * 0.06,
                  )
                ],
              ),
              SizedBox(
                height: displayHWidth * .05,
              ),
              GetBuilder(
                  init: searchText,
                  builder: (controller) => searchText.searchList.isNotEmpty
                      ? SearchFound(searchText: searchText)
                      : SearchNotFound(displayHeight: displayHeight))
            ],
          ),
        ),
      ),
    );
  }
}

class SearchNotFound extends StatelessWidget {
  const SearchNotFound({
    super.key,
    required this.displayHeight,
  });

  final double displayHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: displayHeight * .5,
        child: Center(child: Text('No producttttt14 pro found')));
  }
}

class SearchFound extends StatelessWidget {
  const SearchFound({
    super.key,
    required this.searchText,
  });

  final SearchController searchText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: searchText.searchList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Material(
            elevation: 7,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () {
                Get.to(() =>
                    ProductDetails(productId: searchText.searchList[index].id));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                // margin: EdgeInsets.all(0),
                // elevation: 5,
                height: 100,

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 125,
                      width: 140,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(searchText.searchList[index]
                                  ['productImg1']))),
                    ),
                    Text(searchText.searchList[index]['productName']),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '₹ ${searchText.searchList[index]['productPrice']}',
                          style: const TextStyle(color: kPrimaryColor),
                        ),
                        // FutureBuilder(
                        //     future: WishlistService().checkWishlist(
                        //         productid:
                        //             snapshot.data!.docs[index].id),
                        //     builder: (context, snapshot1) {
                        //       return GetBuilder<WishlistController>(
                        //         builder: (controllerobj) => InkWell(
                        //           onTap: () {
                        //             if (snapshot1.data == true) {
                        //               WishlistService()
                        //                   .removeWishlist(
                        //                       context: context,
                        //                       productid: snapshot
                        //                           .data!
                        //                           .docs[index]
                        //                           .id);
                        //             } else {
                        //               WishlistService()
                        //                   .addToWishlist(
                        //                       context: context,
                        //                       productid: snapshot
                        //                           .data!
                        //                           .docs[index]
                        //                           .id);
                        //             }
                        //             controllerobj.updateIcon(
                        //                 isContain:
                        //                     !snapshot1.data!);
                        //             a = !snapshot1.data!;
                        //           },
                        //           child: Container(
                        //               height: 20,
                        //               width: 20,
                        //               decoration: BoxDecoration(
                        //                   color: Colors.grey[300],
                        //                   borderRadius:
                        //                       BorderRadius.circular(
                        //                           50)),
                        //               child: a
                        //                   ? const Icon(
                        //                       Icons
                        //                           .favorite_rounded,
                        //                       size: 15,
                        //                     )
                        //                   : const Icon(
                        //                       Icons
                        //                           .favorite_outline_rounded,
                        //                       size: 15,
                        //                     )),
                        //         ),
                        //       );
                        //     })
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
