import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:protegelapp/screens/repository/authentication_repository/authentication_repository.dart';
import 'package:protegelapp/screens/repository/authentication_repository/exceptions/t_exceptions.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser(String email, String password) {
    AuthenticationRepository.instance
        .loginWithEmailAndPassword(email, password);
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.code(e.code);
      Get.snackbar('Error', 'FIREBASE AUTH EXCEPTION - ${ex.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color.fromARGB(255, 223, 196, 196).withOpacity(0.1),
          colorText: Colors.black);
      throw ex;
    } catch (_) {
      const ex = TExceptions();
      print('FIREBASE AUTH EXCEPTION: ${ex.message}');
      throw ex;
    }
  }

  Future<void> signInWithFacebook() async {}

  Future<void> loginWithPhoneNo() async {}
}
