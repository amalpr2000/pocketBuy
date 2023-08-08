import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/controller/address_screen_controller.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/model/address_model.dart';
import 'package:pocketbuy/view/address/widgets/address_adding.dart';
import 'package:pocketbuy/view/checkout/checkout_screen.dart';

class AddressScrn extends StatelessWidget {
  AddressScrn({super.key});

  final AddressScrnController addressScrnController = AddressScrnController();
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    addressScrnController.getAddressList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Address'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<AddressScrnController>(
                init: addressScrnController,
                builder: (controller) {
                  bool isListempty = controller.addressList.isEmpty;

                  return isListempty ? addressListIsEmpty() : addressListBuilder(context: context);
                }),
          ),
          SizedBox(
            height: displayHeight * 0.08,
            child: ColoredBox(
              color: Colors.white,
              child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        _addAddress(context);
                      },
                      style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(
                              Size(displayWidth * 0.6, displayHeight * 0.01)),
                          backgroundColor: const MaterialStatePropertyAll(kPrimaryColor),
                          foregroundColor: const MaterialStatePropertyAll(Colors.white),
                          shape: const MaterialStatePropertyAll(ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ))),
                      child: const Text(
                        'ADD ADDRESS',
                      ))),
            ),
          )
        ],
      ),
    );
  }

  addressListBuilder({required BuildContext context}) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    var addresslist = addressScrnController.addressList;
    int selectedIndex = addressScrnController.selectedIndex!;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkoutAddControl.setter(initAddress: addresslist[selectedIndex]);
    });

    return ListView.builder(
      itemCount: addresslist.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(displayWidth * 0.03),
        child: InkWell(
          onTap: () => addressScrnController.changeSelected(newindex: index),
          child: addressCard(
              isSelected: selectedIndex == index, address: addresslist[index], context: context),
        ),
      ),
    );
  }

  Widget addressCard(
      {required bool isSelected, required AddressModel address, required BuildContext context}) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 4,
      color: Colors.grey[100],
      child: SizedBox(
        height: displayHeight * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(), shape: BoxShape.circle),
              width: displayWidth * 0.08,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? kPrimaryColor : Colors.transparent),
                  width: displayWidth * 0.05,
                ),
              ),
            ),
            SizedBox(
              width: displayWidth * 0.7,
              child: addressContainer(address: address),
            )
          ],
        ),
      ),
    );
  }

  Widget addressContainer({required AddressModel address}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          address.localAddress,
          overflow: TextOverflow.ellipsis,
        ),
        Text('${address.city}, ${address.district}'),
        Text('${address.state},'),
        Text('Pin: ${address.pincode}'),
        address.landmark != 'no landmark'
            ? Text('landmark: ${address.landmark}')
            : const SizedBox(),
      ],
    );
  }

  Widget addressListIsEmpty() {
    return Center(
      child:
          Column(mainAxisSize: MainAxisSize.min, children: [const Text('Address list is empty')]),
    );
  }

  void _addAddress(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (_) {
          return AddressAdding(
            addressScrnController: addressScrnController,
          );
        });
  }
}
