import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/app/modules/activity_list/controllers/activity_list_controller.dart';
import 'package:machine_task/app/modules/activity_list/views/activity_list_view.dart';

import '../../../data/resources/constant_resources.dart';
import '../../home/views/home_view.dart';

class BottomNavBarController extends GetxController with StateMixin<bool> {
  final isLoading = false.obs;

  final currentIndex = 0.obs;
  final navBarItem = <BottomNavigationBarItem>[].obs;
  final screenItem = [].obs;

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    navBarItem.value = [
      BottomNavigationBarItem(
          label: "Home",
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Icon(Icons.home),
          )),
      BottomNavigationBarItem(
          label: 'Activity',
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Icon(Icons.local_activity),
          )),
      BottomNavigationBarItem(
          label: "Rewards",
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Icon(Icons.reviews_sharp),
          )),
      BottomNavigationBarItem(
          label: 'Account',
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Icon(Icons.account_box),
          )),
    ];
    screenItem.value = [
      const HomeView(),
      Center(
        child: Image.asset(
          'assets/comming_soon.jpg',
          height: 200,
          width: DEVICE_WIDTH,
        ),
      ),
      Center(
        child: Image.asset(
          'assets/comming_soon.jpg',
          height: 200,
          width: DEVICE_WIDTH,
        ),
      ),
      const ActivityListView(),
    ];
    change(null, status: RxStatus.success());
    super.onInit();
  }
}
