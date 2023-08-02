import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/controller/address_screen_controller.dart';

import 'package:pocketbuy/controller/address_text_controller.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/service/validation/validation_service.dart';

final GlobalKey<FormState> formkey = GlobalKey<FormState>();

class AddressAdding extends StatelessWidget {
  AddressAdding({super.key, required this.addressScrnController});
  final AddressScrnController addressScrnController;

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;

    return GetBuilder<AddressTextController>(
      init: AddressTextController(),
      builder: (textCon) {
        var localAddressCon = textCon.localAddressCon;
        var cityController = textCon.cityController;
        var districtController = textCon.districtController;
        var stateController = textCon.stateController;
        var pinController = textCon.pinController;
        var landmark = textCon.landmark;
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: displayHeight * 0.03,
                horizontal: displayWidth * 0.02),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.add_location_alt_outlined,
                            color: kwhite),
                        Text(
                          'ADD ADDRESS',
                        ),
                      ],
                    ),
                    sizedboxwithheight(displayHeight * 0.03),
                    textfield(
                      hint: 'Local Address',
                      keyboardtype: TextInputType.streetAddress,
                      controller: localAddressCon,
                    ),
                    sizedboxwithheight(displayHeight * 0.03),
                    textfield(
                      hint: 'City',
                      keyboardtype: TextInputType.name,
                      controller: cityController,
                    ),
                    sizedboxwithheight(displayHeight * 0.03),
                    textfield(
                      hint: 'District',
                      keyboardtype: TextInputType.name,
                      controller: districtController,
                    ),
                    sizedboxwithheight(displayHeight * 0.03),
                    textfield(
                      hint: 'State',
                      keyboardtype: TextInputType.name,
                      controller: stateController,
                    ),
                    sizedboxwithheight(displayHeight * 0.03),
                    textfield(
                      hint: 'Pincode',
                      keyboardtype: TextInputType.number,
                      controller: pinController,
                    ),
                    sizedboxwithheight(displayHeight * 0.03),
                    textfield(
                      hint: 'Landmark (optional)',
                      controller: landmark,
                      keyboardtype: TextInputType.text,
                      isOptional: true,
                    ),
                    sizedboxwithheight(displayHeight * 0.05),
                    addAddressButton(context: context, controller: textCon)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget textfield(
      {required TextEditingController controller,
      required String hint,
      required TextInputType keyboardtype,
      bool isOptional = false}) {
    return TextFormField(
      validator: (value) =>
          Validation().addressValidation(isOptional: isOptional, value: value),
      controller: controller,
      decoration: InputDecoration(
          fillColor: kwhite,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.not_listed_location_rounded),
          prefixIconColor: Colors.black,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.black,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.black,
              ))),
      keyboardType: keyboardtype,
    );
  }

  Widget addAddressButton(
      {required BuildContext context,
      required AddressTextController controller}) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            if (formkey.currentState!.validate()) {
              Navigator.of(context).pop();
              await controller.addressAdding();
              addressScrnController.getAddressList();
            }
          },
          style: ButtonStyle(
              fixedSize: MaterialStatePropertyAll(
                  Size(displayWidth * 0.5, displayHeight * 0.01)),
              backgroundColor: const MaterialStatePropertyAll(Colors.white),
              foregroundColor: const MaterialStatePropertyAll(Colors.black),
              shape:
                  const MaterialStatePropertyAll(ContinuousRectangleBorder())),
          child: Text(
            'ADD ADDRESS',
          )),
    );
  }
}
