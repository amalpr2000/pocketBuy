import 'package:flutter/material.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/view/settings/widgets/on_tap_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  settingsOntap(index: index, context: context);
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                tileColor: Colors.grey[100],
                title: Text(menuTitle[index]),
                leading: Icon(
                  menuIcon[index],
                  size: 30,
                  color: kPrimaryColor,
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: kSecondaryColor,
                    )),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
            itemCount: menuTitle.length),
      ),
    );
  }
}

List menuTitle = ['About', 'Invite Friends', 'Privacy Policy', 'Terms and Conditions'];
List menuIcon = [
  Icons.info_rounded,
  Icons.share,
  Icons.privacy_tip_rounded,
  Icons.menu_book_rounded
];
