import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protegelapp/screens/forget_password/otp/otp_screen.dart';
import 'package:protegelapp/screens/home_screen.dart';
import 'package:protegelapp/screens/repository/authentication_repository/authentication_repository.dart';
import 'package:protegelapp/screens/repository/authentication_repository/models/user_model.dart';
import 'package:protegelapp/screens/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());

  void registerUser(String email, String password) async {
    await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    // phoneAuthentication(user.phoneNo);
    registerUser(user.email, user.password);

    Get.to(() => HomeScreen());
    // Get.to(() => OTPScreen());
  }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
