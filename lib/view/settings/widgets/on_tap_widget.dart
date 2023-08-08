import 'package:flutter/material.dart';
import 'package:get/get.dart';


settingsOntap({required index, required BuildContext context}) {
  if (index == 2) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: const Text('Privacy Policy')),
        content: const SingleChildScrollView(
            child: Text(
          '''At Pocket Buy, we respect and protect the privacy of our users. This Privacy Policy explains how we collect, use, and disclose information about our users.

Information We Collect:

We collect information that you provide to us directly, such as when you create an account, upload songs, or use our app to stream music. This information may include your name, email address, phone number, and payment information.

We also collect information automatically as you use our app, such as your device type, operating system, IP address, and usage information. This information is collected through cookies, web beacons, and other tracking technologies.

How We Use Your Information:

We use the information we collect to provide and improve our app, personalize your experience, and communicate with you. This includes providing customer support, sending you promotional offers, and analyzing how our app is used.

We may also share your information with third-party service providers who help us with various functions, such as hosting our app, processing payments, and analyzing user data.

How We Protect Your Information:

We take reasonable measures to protect your information from unauthorized access, use, or disclosure. This includes using encryption, firewalls, and other security measures to protect your data.

However, no method of transmission over the internet or electronic storage is 100% secure, so we cannot guarantee absolute security.

Your Choices:

You can choose not to provide certain information to us, but this may limit your ability to use our app. You can also opt-out of receiving promotional emails from us by following the instructions in the email.

You can also control certain tracking technologies through your device settings or by using third-party tools.

Changes to this Policy:

We may update this Privacy Policy from time to time. If we make significant changes, we will notify you by email or by posting a notice in our app.

Contact Us:

If you have any questions or concerns about this Privacy Policy, please contact us at amalpr2000@gmail.com.
''',
          textAlign: TextAlign.left,
        )),
        actions: [TextButton(onPressed: () => Get.back(), child: Center(child: Text('close')))],
      ),
    );
  }

  if (index == 3) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: const Text('Terms and Conditions')),
        content: const SingleChildScrollView(
            child: Text(
          '''The following terms and conditions govern your use of the e-commerce mobile application (Pocket Buy) developed by Amal P R. Please read these terms and conditions carefully before using the Application.
By using the Application, you agree to be bound by these terms and conditions. If you do not agree to these terms and conditions, you may not use the Application.
License:
The Application is licensed, not sold, to you for use strictly in accordance with the terms and conditions of this license. Developer reserves all rights not expressly granted to you.
Restrictions:
You may not:
a. Modify, reverse engineer, decompile or disassemble the Application in any way.
b. Rent, lease, lend, sell, redistribute or sublicense the Application.
c. Use the Application for any unlawful purpose or in any way that violates any applicable laws or regulations.
Ownership:
The Application and all intellectual property rights, including but not limited to copyrights, patents, trademarks, and trade secrets, in and to the Application, are owned by Developer.
Privacy:
The Application may collect personal information from you. Please refer to Developer's Privacy Policy for more information on how your personal information is collected, used, and disclosed.
Warranty:
The Application is provided “as is” without warranty of any kind, either express or implied, including but not limited to the implied warranties of merchantability and fitness for a particular purpose. Developer does not warrant that the Application will meet your requirements or that the operation of the Application will be uninterrupted or error-free.
Limitation of Liability:
In no event shall Developer be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in connection with the use or inability to use the Application, even if Developer has been advised of the possibility of such damages.
Indemnification:
You agree to indemnify and hold Developer harmless from any and all claims, damages, expenses, and liabilities, including attorneys' fees, arising out of or in connection with your use of the Application.
Termination:
This license is effective until terminated by you or Developer. Your rights under this license will terminate automatically without notice from Developer if you fail to comply with any term or condition of this license. Upon termination of the license, you shall cease all use of the Application and destroy all copies, full or partial, of the Application.
Governing Law:
This license and your use of the Application shall be governed by and construed in accordance with the laws of India, without giving effect to any choice of law or conflict of law provisions.
Entire Agreement:
This license constitutes the entire agreement between you and Developer relating to the Application and supersedes all prior or contemporaneous oral or written communications, proposals, and representations with respect to the Application or any other subject matter covered by this license.
By using the Application, you acknowledge that you have read this license, understand it, and agree to be bound by its terms and conditions.


''',
          textAlign: TextAlign.left,
        )),
        actions: [TextButton(onPressed: () => Get.back(), child: Center(child: Text('close')))],
      ),
    );
  }
  if (index == 1) {
    // Share.share(
    //     'Check out this awesome app!\nhttps://play.google.com/store/apps/details?id=com.amalpr.pocketbuy');
  }
  if (index == 0) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: const Text('About')),
        content: Text(
          '''Pocket Buy
Developer: Amal P R
Copyright (c) 2023. All rights reserved.

Pocket Buy is a free, E-commerce app designed for Android and iOS devices. We aim to deliver exceptional products and services while fostering trust and transparency with our users. Our team members are dedicated to providing the best customer experience, and we value sustainability and eco-conscious practices. Positive customer testimonials and awards attest to our commitment to quality. We prioritize data protection and user rights, as outlined in our privacy policy and terms of service. Reach out to our friendly customer support for assistance, and follow us on social media for updates and engaging content.
Thank you for using Pocket Buy!
''',
          textAlign: TextAlign.left,
        ),
        actions: [TextButton(onPressed: () => Get.back(), child: Center(child: Text('close')))],
      ),
    );
  }
}
