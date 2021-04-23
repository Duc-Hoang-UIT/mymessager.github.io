import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/services/AuthenticationController.dart';

class RegisterController extends RxController {
  Authentication _authentication = Authentication();
  Rx<TextEditingController> emailEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> nameEditingController = TextEditingController().obs;
  Rx<TextEditingController> passwordEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> confirmEditingController =
      TextEditingController().obs;
  Future<void> createAccount(String name, String email, String password) async {
    await _authentication.createUser(name, email, password);
    Get.back();
  }
}
