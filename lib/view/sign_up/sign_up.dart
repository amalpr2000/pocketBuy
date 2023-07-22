import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/service/auth/authentication.dart';
import 'package:pocketbuy/view/log_in/log_in_screen.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});
  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  TextEditingController _reEnterPassword=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kHeight20,
                const Text(
                  'Register Account',
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                kHeight20,
                const Text(
                  'Complete your details or continue \n with social media ',
                  style: TextStyle(color: kSecondaryColor),
                  textAlign: TextAlign.center,
                ),
                kHeight40,
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        labelText: 'Enter your email',
                        labelStyle: const TextStyle(color: kSecondaryColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        suffixIcon: const Icon(Icons.mail_outline_rounded)),
                  ),
                ),
                kHeight40,
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        labelText: 'Enter your password',
                        labelStyle: const TextStyle(color: kSecondaryColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        suffixIcon: const Icon(Icons.lock_outline_rounded)),
                  ),
                ),
                kHeight40,
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    controller: _reEnterPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        labelText: 'Re-enter your password',
                        labelStyle: const TextStyle(color: kSecondaryColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        suffixIcon: const Icon(Icons.lock_outline_rounded)),
                  ),
                ),
                kHeight40,
                SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        // style: ButtonStyle(backgroundColor: Colors.orange),
                        onPressed: () {
                          Authentication().registerWtihEmailAndPassword(email: _email.text, password: _password.text).then((success) {
                            if(success){
                              Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>  LoginScreen(),
                              ),
                              (route) => false);
                            }else{
                              Get.snackbar('Error', 'message');
                            }
                          });
                          
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: kwhite),
                        ))),
                kHeight40,
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(50),
                //   child: Image.network(
                //     'https://e7.pngegg.com/pngimages/114/607/png-clipart-g-suite-pearl-river-middle-school-google-software-suite-email-sign-up-button-text-logo.png',
                //     width: 40,
                //   ),
                // ),
                kHeight40,
                const Text(
                  "By signup your confirm that you agree \n        with our terms and conditions ",
                  style: TextStyle(color: kSecondaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
