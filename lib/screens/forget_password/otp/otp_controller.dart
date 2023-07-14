import 'package:get/get.dart';
import 'package:protegelapp/screens/repository/authentication_repository/authentication_repository.dart';
import 'package:protegelapp/screens/home_screen.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomeScreen()) : Get.back();
  }
}
