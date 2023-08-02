import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocketbuy/utils/snackbar.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> registerWtihEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.email)
            .set({
          'name': value.user?.displayName ?? 'Not added',
          'email': email,
          'phone': value.user?.phoneNumber ?? 'Not added',
          'image': value.user?.photoURL ?? 'Not added',
        }, SetOptions(merge: true));
        return value;
      });

      User? user = userCredential.user;
      return true;
    } on FirebaseException catch (e) {
      Get.snackbar('Error during signup', e.message!);

      return false;
    }
  }

  Future<bool> signInWtihEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return true;
    } on FirebaseException catch (e) {
      Get.snackbar('Error during login', e.message!);
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error during login', e.message!);

      print('Error during sign-out: $e');
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.email)
            .set({
          'name': value.user?.displayName ?? 'Not added',
          'email': value.user?.email ?? 'Not added',
          'phone': value.user?.phoneNumber ?? 'Not added',
          'image': value.user?.photoURL ?? 'Not added',
        }, SetOptions(merge: true));
        return value;
      });

      return userCredential;
    } catch (e) {
      Get.snackbar('Error during login', '$e');

      // print('Error signing in with Google: $e');
      return throw e;
    }
  }
}
