import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:machine_task/app/common_views/common_button.dart';
import 'package:machine_task/app/data/resources/constant_resources.dart';

import '../../../data/resources/color_resources.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put<HomeController>(HomeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DARK_BLUE,
        title: Text(
          'List',
          style: h4_dark(context)?.copyWith(
              color: WHITE, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Column(
        mainAxisAlignment: MAIN_AXIS_CENTER,
        crossAxisAlignment: CROSS_AXIS_CENTER,
        children: [
          Center(
              child: Text(
            'Welcome!!!',
            style: h4_dark(context),
          )),
          SPACING_MEDIUM_HEIGHT,
          Center(
            child: SizedBox(
              height: 50,
              width: 120,
              child: CommonButton(
                title: 'Logout',
                onTap: () => controller.signOutBtnOnTap(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
