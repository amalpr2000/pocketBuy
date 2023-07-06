import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy/core/colors.dart';
import 'package:pocketbuy/core/constants.dart';
import 'package:pocketbuy/view/bottom_nav.dart';
import 'package:pocketbuy/view/sign_up/sign_up.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
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
                  'Welcome',
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                kHeight20,
                const Text(
                  'Sign in with your email and password \n continue with social media ',
                  style: TextStyle(color: kSecondaryColor),
                  textAlign: TextAlign.center,
                ),
                kHeight40,
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    controller: _emailController,
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
                    controller: _passwordController,
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
                kHeight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Forget password?',
                      style: TextStyle(color: kSecondaryColor),
                    ),
                  ],
                ),
                kHeight40,
                SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        // style: ButtonStyle(backgroundColor: Colors.orange),
                        onPressed: () {
                          // Authentication()
                          //     .signInWtihEmailAndPassword(
                          //         email: _emailController.text,
                          //         password: _passwordController.text)
                          //     .then((success) {
                          //   if (success) {
                          //     Navigator.of(context)
                          //         .pushReplacement(MaterialPageRoute(
                          //       builder: (context) => const HomeScreen(),
                          //     ));
                          //   } else {
                          //     Get.snackbar('Error', 'message');
                          //   }
                          // });
                          Get.off(() => BottomNavBarWidget());
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: kwhite),
                        ))),
                kHeight40,
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    'https://e7.pngegg.com/pngimages/114/607/png-clipart-g-suite-pearl-river-middle-school-google-software-suite-email-sign-up-button-text-logo.png',
                    width: 40,
                  ),
                ),
                kHeight40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?  ",
                      style: TextStyle(color: kSecondaryColor),
                    ),
                    InkWell(
                      mouseCursor: SystemMouseCursors.click,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
