import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:machine_task/app/common_views/show_toast.dart';
import 'package:machine_task/app/data/funtions/google_login.dart';
import 'package:machine_task/app/data/local_storage/local_storage.dart';

import '../../../data/funtions/log/log.dart';
import '../../../data/resources/constant_resources.dart';
import '../../../routes/app_pages.dart';

class RegistrationController extends GetxController with StateMixin<bool> {
  final isLoading = false.obs;

  final TextEditingController userNameTextController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();
  final GlobalKey<FormState> userNameFormKey = GlobalKey();

  final TextEditingController emailTextController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final GlobalKey<FormState> emailFormKey = GlobalKey();

  final TextEditingController phoneNoTextController = TextEditingController();
  final FocusNode phoneNoFocusNode = FocusNode();
  final GlobalKey<FormState> phoneNoFormKey = GlobalKey();

  final TextEditingController passwordTextController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> passwordFormKey = GlobalKey();

  final TextEditingController conPasswordTextController =
      TextEditingController();
  final FocusNode conPasswordFocusNode = FocusNode();
  final GlobalKey<FormState> conPasswordFormKey = GlobalKey();

  final obscurePasswordText = false.obs;
  final obscureConPasswordText = false.obs;

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void passwordVisibilityIconOnTap() =>
      obscurePasswordText.value = !obscurePasswordText.value;
  void conPasswordVisibilityIconOnTap() =>
      obscureConPasswordText.value = !obscureConPasswordText.value;

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await Google().googleLogIn();
    if (googleSignInAccount != null) {
      Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
    }
  }

  Future<void> registerBtnOnTap() async {
    bool isvalidEachFields = validateEachFields();
    if (!isvalidEachFields) return;
    isLoading.value = true;
    final _auth = FirebaseAuth.instance;
    try {
      final response = await _auth.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      Log.info(info: 'registration controller ~ response ~ $response');
      if (response != null) {
        showToast(message: 'Registration successfully');
        await LocalStorage.saveIsLoggedIn(true);
        Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
      }
    } on FirebaseAuthException catch (error) {
      Log.info(
          info: 'registration controller ~ exception code ~ ${error.code}');
      // if (error.code == 'email-already-in-use') {
      // }
      showToast(message: error.message ?? 'Invalid Email');
    } catch (e) {
      Log.info(info: 'registration controller ~ exception ~ $e');
    }
    isLoading.value = false;
  }

  bool validateEachFields() {
    if (!userNameFormKey.currentState!.validate()) {
      Scrollable.ensureVisible(userNameFormKey.currentContext!,
          duration: FIVE_HUNDRED_MIL, curve: Curves.fastOutSlowIn);
      userNameFocusNode.requestFocus();
      return false;
    }
    if (!emailFormKey.currentState!.validate()) {
      Scrollable.ensureVisible(emailFormKey.currentContext!,
          duration: FIVE_HUNDRED_MIL, curve: Curves.fastOutSlowIn);
      emailFocusNode.requestFocus();
      return false;
    }

    if (!phoneNoFormKey.currentState!.validate()) {
      Scrollable.ensureVisible(phoneNoFormKey.currentContext!,
          duration: FIVE_HUNDRED_MIL, curve: Curves.fastOutSlowIn);
      phoneNoFocusNode.requestFocus();
      return false;
    }
    if (!passwordFormKey.currentState!.validate()) {
      Scrollable.ensureVisible(passwordFormKey.currentContext!,
          duration: FIVE_HUNDRED_MIL, curve: Curves.fastOutSlowIn);
      passwordFocusNode.requestFocus();
      return false;
    }
    if (!conPasswordFormKey.currentState!.validate()) {
      Scrollable.ensureVisible(conPasswordFormKey.currentContext!,
          duration: FIVE_HUNDRED_MIL, curve: Curves.fastOutSlowIn);
      conPasswordFocusNode.requestFocus();
      return false;
    }
    return true;
  }
}
