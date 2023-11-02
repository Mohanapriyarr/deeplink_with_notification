import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common_views/common_button.dart';
import '../../../common_views/initial_loader.dart';
import '../../../common_views/input_field.dart';
import '../../../common_views/intermediate_loader.dart';
import '../../../data/funtions/field_validations.dart';
import '../../../data/resources/color_resources.dart';
import '../../../data/resources/constant_resources.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
            children: [
              controller.obx(
                (state) => MainChild(
                  controller: controller,
                ),
                onLoading: const InitialLoader(),
                onError: ((error) => Text(
                      error.toString(),
                      style: h4_dark(context),
                    )),
              ),
              controller.isLoading.isTrue
                  ? const IntermediateLoader()
                  : SHOW_NOTHING
            ],
          )),
    );
  }
}

class MainChild extends StatelessWidget with FieldValidations {
  final LoginController controller;

  const MainChild({super.key, required this.controller});
  @override
  Widget build(BuildContext context) => SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: WillPopScope(
            onWillPop: () async => true,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: PAD_20,
                child: Column(
                  crossAxisAlignment: CROSS_AXIS_START,
                  children: [
                    SPACING_MEDIUM_HEIGHT,
                    SPACING_MEDIUM_HEIGHT,
                    Text(
                      'Login',
                      style: h4_dark(context)?.copyWith(
                          fontSize: 25,
                          color: DARK_BLUE,
                          fontWeight: FontWeight.bold),
                    ),
                    SPACING_MEDIUM_HEIGHT,
                    Form(
                      key: controller.emailFormKey,
                      child: RegisCommonField(
                          context: context,
                          textEditingController: controller.emailTextController,
                          focusNode: controller.emailFocusNode,
                          hintText: 'Enter Your Email',
                          needNext: false,
                          validator: (value) => emailValidation(value),
                          keyboardType: TYPE_EMAIL!,
                          title: 'Email'),
                    ),
                    SPACING_SMALL_HEIGHT,
                    Obx(
                      () => Form(
                        key: controller.passwordFormKey,
                        child: RegisCommonField(
                            context: context,
                            title: 'Password',
                            textEditingController:
                                controller.passwordTextController,
                            focusNode: controller.passwordFocusNode,
                            hintText: 'Please Enter Your Password',
                            needNext: true,
                            suffixIcon: controller.obscurePasswordText.isTrue
                                ? Icon(
                                    Icons.visibility_off,
                                    color: DARK_BLUE,
                                    size: 18,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: DARK_BLUE,
                                    size: 18,
                                  ),
                            obscureText: controller.obscurePasswordText.value,
                            keyboardType: TYPE_EMAIL!,
                            suffixIconTap: () =>
                                controller.passwordVisibilityIconOnTap(),
                            validator: (value) => passwordValidation(
                                value, 'Please Enter Your Password')),
                      ),
                    ),
                    SPACING_LARGE_HEIGHT,
                    CommonButton(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      title: 'Login',
                      onTap: () async => await controller.loginBtnOnTap(),
                    ),
                    SPACING_MEDIUM_HEIGHT,
                    Row(
                      mainAxisAlignment: MAIN_AXIS_CENTER,
                      children: [
                        Text(
                          'Don\'t have an Account?',
                          style: h4_dark(context),
                        ),
                        SPACING_VVSMALL_WIDTH,
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.REGISTRATION),
                          child: Text(
                            'Register',
                            style: h4_dark(context)?.copyWith(
                                color: BLACK, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SPACING_MEDIUM_HEIGHT,
                    SPACING_MEDIUM_HEIGHT,
                    GestureDetector(
                      onTap: () async => await controller.signInWithGoogle(),
                      child: Center(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: APP_LIGHT_GREY_INPUT_FIELD)),
                          child: Wrap(
                            children: [
                              Image.asset(
                                'assets/google.png',
                                height: 30,
                                width: 30,
                              ),
                              SPACING_SMALL_WIDTH,
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Continue with Google',
                                  style: h4_dark(context)?.copyWith(
                                      color: BLUE, fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

Widget RegisCommonField({
  required BuildContext context,
  required TextEditingController textEditingController,
  required FocusNode focusNode,
  required String hintText,
  Icon? prefixIcon,
  Icon? suffixIcon,
  TextCapitalization textCapital = NONE,
  bool obscureText = false,
  required bool needNext,
  required TextInputType keyboardType,
  dynamic Function(String)? onFieldSubmitted,
  String? Function(String?)? validator,
  required String title,
  final Function()? suffixIconTap,
}) {
  return Column(
    mainAxisSize: MAX,
    crossAxisAlignment: CROSS_AXIS_START,
    children: [
      Text(
        title,
        style: h4_dark(context),
      ),
      SPACING_VVSMALL_HEIGHT,
      InputField(
        textEditingController: textEditingController,
        focusNode: focusNode,
        textCapital: textCapital,
        keyboardType: keyboardType,
        textInputAction: needNext ? INPUT_NEXT : INPUT_DONE,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        obscureText: obscureText,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        suffixIconTap: suffixIconTap,
      ),
    ],
  );
}
