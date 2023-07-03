import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:protegelapp/screens/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:protegelapp/screens/home_screen.dart';
import 'package:protegelapp/screens/welcome_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

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

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION: ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailPasswordFailure();
      print('FIREBASE AUTH EXCEPTION: ${ex.message}');
      throw ex;
    }

    Future<void> loginWithEmailAndPassword(
        String email, String password) async {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (e) {
      } catch (_) {}

      Future<void> logout() async => _auth.signOut();
    }
  }
}
