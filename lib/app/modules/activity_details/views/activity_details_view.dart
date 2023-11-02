import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common_views/initial_loader.dart';
import '../../../common_views/intermediate_loader.dart';
import '../../../data/resources/color_resources.dart';
import '../../../data/resources/constant_resources.dart';
import '../controllers/activity_details_controller.dart';

class ActivityDetailsView extends GetView<ActivityDetailsController> {
  const ActivityDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              controller.obx(
                (state) => _mainChild(context: context),
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

  Widget _mainChild({required BuildContext context}) => Padding(
        padding: PAD_12,
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(
            width: DEVICE_WIDTH,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                  mainAxisSize: MIN,
                  crossAxisAlignment: CROSS_AXIS_START,
                  children: [
                    SPACING_MEDIUM_HEIGHT,
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(controller.detailsModel!.data.avatar),
                      ),
                    ),
                    SPACING_MEDIUM_HEIGHT,
                    Text(
                      'Name: ${controller.detailsModel!.data.firstName} ${controller.detailsModel!.data.lastName}',
                      style: h4_dark(context),
                    ),
                    SPACING_VSMALL_HEIGHT,
                    Text(
                      'Email: ${controller.detailsModel!.data.email}',
                      style: h4_dark(context),
                    ),
                    SPACING_VSMALL_HEIGHT,
                    Text(
                      'Description:${controller.detailsModel!.support.text}',
                      style: h4_dark(context),
                    ),
                    SPACING_MEDIUM_HEIGHT,
                  ]),
            ),
          ),
        ),
      );
}
