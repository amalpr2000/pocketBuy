import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocketbuy/controller/user_editing_controller.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/service/auth/wishlist.dart';
import 'package:pocketbuy/utils/snackbar.dart';
import 'package:pocketbuy/view/my_account/widgets/text_field_widget.dart';

var formkey = GlobalKey<FormState>();

class UserDataEditor extends StatelessWidget {
  const UserDataEditor(
      {super.key, this.isname = false, required this.initialText, required this.ctx});
  final bool isname;
  final String initialText;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    var controller = UserEditingController(initialData: initialText).editingController;
    return AlertDialog(
      title: Text(isname ? 'Name' : 'Phone'),
      content: Form(
        key: formkey,
        child: TextFieldCustom(
          hint: isname ? 'Name' : 'Phone',
          controller: controller,
          isname: isname,
          isphone: !isname,
          inputType: isname ? TextInputType.name : TextInputType.number,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                if (isname) {
                  usernameChange(value: controller.text.trim(), isname: true, context: ctx);
                } else {
                  usernameChange(value: controller.text.trim(), isname: false, context: ctx);
                }
                Navigator.of(context).pop();
              }
            },
            child: const Text('Change'))
      ],
    );
  }

  usernameChange(
      {required String value, required bool isname, required BuildContext context}) async {
    Map<String, dynamic> data = isname ? {'name': value} : {'phone': value};
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentEmail)
        .set(data, SetOptions(merge: true))
        .then((value) {
      customSnackbar(title: 'Edited', msg: 'Successfully changed', barColor: snackGreen);
    });
  }
}
