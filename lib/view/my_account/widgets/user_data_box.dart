import 'package:flutter/material.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/view/my_account/widgets/edit_pop_up.dart';

class UserDataBox extends StatelessWidget {
  const UserDataBox({
    super.key,
    required this.title,
    required this.ctx,
    required this.data,
    this.isEmail = false,
    this.isName = false,
    this.isPhone = false,
  });
  final String title;
  final String data;
  final bool isName;
  final bool isEmail;
  final bool isPhone;
  final BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: displayHeight * 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: kSecondaryColor),
                borderRadius: BorderRadius.circular(12)),
            width: displayWidth * 0.8,
            padding: const EdgeInsets.only(left: 20),
            height: 40,
            child: isEmail
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data,
                    ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data,
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => UserDataEditor(
                                isname: isName,
                                initialText: data,
                                ctx: ctx,
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: kSecondaryColor,
                          ))
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
