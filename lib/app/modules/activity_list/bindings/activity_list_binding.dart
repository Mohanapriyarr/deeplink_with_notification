import 'package:get/get.dart';

import '../controllers/activity_list_controller.dart';

class ActivityListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityListController>(
      () => ActivityListController(),
    );
  }
}
