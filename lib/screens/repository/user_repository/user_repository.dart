import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protegelapp/screens/repository/authentication_repository/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created",
              snackPosition: SnackPosition.TOP,
              backgroundColor:
                  Color.fromARGB(255, 223, 196, 196).withOpacity(0.1),
              colorText: Colors.black),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color.fromARGB(255, 223, 196, 196).withOpacity(0.1),
          colorText: Colors.black);
      print(error.toString());
    });
  }
}
