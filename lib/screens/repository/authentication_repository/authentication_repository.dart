import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protegelapp/screens/repository/authentication_repository/exceptions/t_exceptions.dart';
import 'package:protegelapp/screens/forget_password/otp/otp_screen.dart';
import 'package:protegelapp/screens/home_screen.dart';
import 'package:protegelapp/screens/welcome_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const HomeScreen());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
        verificationFailed: (e) {
          print(e);
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid.',
                snackPosition: SnackPosition.TOP,
                backgroundColor:
                    Color.fromARGB(255, 223, 196, 196).withOpacity(0.1),
                colorText: Colors.black);
          } else {
            Get.snackbar('Error', 'Something went wrong. Try again.',
                snackPosition: SnackPosition.TOP,
                backgroundColor:
                    Color.fromARGB(255, 223, 196, 196).withOpacity(0.1),
                colorText: Colors.black);
          }
        });
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));

    return credentials.user != null ? true : false;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.to(() => const OTPScreen());
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

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle login exception
    } catch (_) {
      // Handle generic exception
    }
  }

  Future<void> loginAnonymously() async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      // Handle login exception
    } catch (_) {
      // Handle generic exception
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.code(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }
}
