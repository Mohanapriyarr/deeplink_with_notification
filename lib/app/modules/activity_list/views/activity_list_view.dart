import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:machine_task/app/data/resources/color_resources.dart';
import 'package:machine_task/app/routes/app_pages.dart';

import '../../../common_views/initial_loader.dart';
import '../../../common_views/intermediate_loader.dart';
import '../../../data/resources/constant_resources.dart';
import '../controllers/activity_list_controller.dart';

class ActivityListView extends GetView<ActivityListController> {
  const ActivityListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put<ActivityListController>(ActivityListController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DARK_BLUE,
        title: Text(
          'List',
          style: h4_dark(context)?.copyWith(
              color: WHITE, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
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

  Widget _mainChild({required BuildContext context}) => ListView.builder(
      itemCount: controller.itemList.length,
      itemBuilder: (context, i) => GestureDetector(
            onTap: () => Get.toNamed(Routes.ACTIVITY_DETAILS,
                arguments: controller.itemList[i].id),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundImage:
                              NetworkImage(controller.itemList[i].avatar),
                        ),
                        title: Text(
                          '${controller.itemList[i].firstName} ${controller.itemList[i].lastName}',
                          style: h4_dark(context),
                        ),
                        subtitle: Text(
                          controller.itemList[i].email,
                          style: h4_dark(context),
                        ),
                        trailing: Icon(
                          Icons.arrow_circle_right_rounded,
                          color: BLUE,
                          size: 20,
                        )),
                  )),
            ),
          ));
}
