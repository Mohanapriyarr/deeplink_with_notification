import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common_views/initial_loader.dart';
import '../../../common_views/intermediate_loader.dart';
import '../../../data/funtions/log/log.dart';
import '../../../data/resources/color_resources.dart';
import '../../../data/resources/constant_resources.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
            children: [
              Center(
                child: controller.obx(
                  (state) => _mainChild(context: context),
                  onLoading: const InitialLoader(),
                  onError: ((error) => Text(
                        error.toString(),
                        style: h4_dark(context),
                      )),
                ),
              ),
              controller.isLoading.isTrue
                  ? const IntermediateLoader()
                  : SHOW_NOTHING
            ],
          )),
    );
  }

  Widget _mainChild({required BuildContext context}) => Obx(
        () => Column(
          children: [
            Expanded(
              child: controller.screenItem[controller.currentIndex.value],
            ),
            BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: DARK_BLUE,
              unselectedItemColor: APP_LIGHT_GREY,
              selectedLabelStyle: h4_dark(context)?.copyWith(fontSize: 12),
              unselectedLabelStyle: h4_dark(context)?.copyWith(fontSize: 12),
              onTap: (value) {
                Log.info(info: 'value $value');
                controller.currentIndex.value = value;
              },
              items: controller.navBarItem,
            ),
          ],
        ),
      );
}
