import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:machine_task/app/common_views/show_toast.dart';
import 'package:machine_task/app/routes/app_pages.dart';

import '../../../data/funtions/google_login.dart';
import '../../../data/funtions/log/log.dart';
import '../../../data/local_storage/local_storage.dart';
import '../../../data/resources/constant_resources.dart';

class LoginController extends GetxController with StateMixin<bool> {
  final isLoading = false.obs;

  final TextEditingController emailTextController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final GlobalKey<FormState> emailFormKey = GlobalKey();

  final TextEditingController passwordTextController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> passwordFormKey = GlobalKey();

  final obscurePasswordText = false.obs;

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void passwordVisibilityIconOnTap() =>
      obscurePasswordText.value = !obscurePasswordText.value;

  Future<void> loginBtnOnTap() async {
    bool isvalidEachFields = validateEachFields();
    if (!isvalidEachFields) return;
    isLoading.value = true;
    final _auth = FirebaseAuth.instance;
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim());

      if (response != null) {
        Log.info(info: 'login controller ~ response ~ $response');
        showToast(message: 'LoggedIn Successfully');
        await LocalStorage.saveIsLoggedIn(true);
        Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
      }
    } on FirebaseAuthException catch (error) {
      Log.info(info: 'login controller ~ exception code ~ ${error}');
      // if (error.code == 'INVALID_LOGIN_CREDENTIALS') {
      // }
      showToast(message: 'Invalid Login Credentials');
    } catch (e) {
      Log.info(info: 'login controller ~ exception ~ $e');
    }
    isLoading.value = false;
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await Google().googleLogIn();
    if (googleSignInAccount != null) {
      await LocalStorage.saveIsLoggedIn(true);
      Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
    }
  }

  bool validateEachFields() {
    if (!emailFormKey.currentState!.validate()) {
      Scrollable.ensureVisible(emailFormKey.currentContext!,
          duration: FIVE_HUNDRED_MIL, curve: Curves.fastOutSlowIn);
      emailFocusNode.requestFocus();
      return false;
    }

    if (!passwordFormKey.currentState!.validate()) {
      Scrollable.ensureVisible(passwordFormKey.currentContext!,
          duration: FIVE_HUNDRED_MIL, curve: Curves.fastOutSlowIn);
      passwordFocusNode.requestFocus();
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }
}
