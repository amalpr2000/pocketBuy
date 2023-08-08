import 'package:flutter/material.dart';
import 'package:pocketbuy/service/validation/validation_service.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {super.key,
      required this.hint,
      required this.controller,
      this.passwordgiven,
      this.suffix,
      this.isobsecure = false,
      this.inputType = TextInputType.text,
      this.isemail = false,
      this.isname = false,
      this.ispassword = false,
      this.isconfirmpassword = false,
      this.isphone = false});
  final Widget? suffix;
  final bool isobsecure;
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isname;
  final bool isemail;
  final bool ispassword;
  final bool isphone;
  final bool isconfirmpassword;
  final String? passwordgiven;
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      keyboardType: inputType,
      controller: controller,
      obscureText: isobsecure,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: displayWidth * 0.02),
          child: suffix ?? const SizedBox(),
        ),
        iconColor: Colors.black,
        hintText: hint,
       
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      validator: (value) => Validation().validation(
          value: value?.trim(),
          isname: isname,
          isemail: isemail,
          ispassword: ispassword,
          isphone: isphone,
          password: passwordgiven,
          isconfirmpassword: isconfirmpassword),
    );
  }
}