import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mymessager/controllers/UserController/UserController.dart';
import 'package:mymessager/models/UserModel.dart';
import 'package:mymessager/services/database.dart';

class Authentication extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _user = Rx<User>(null);
  User get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  Future<void> createUser(String name, String email, String password) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userModel = UserModel(
        id: _authResult.user.uid,
        name: name,
        email: _authResult.user.email,
      );
      if (await Database().createNewUser(userModel)) {
        Get.find<UserController>().userModel = userModel;
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.find<UserController>().userModel =
          await Database().getUser(_authResult.user.uid);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
