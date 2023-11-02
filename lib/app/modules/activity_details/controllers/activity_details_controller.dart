import 'package:get/get.dart';
import 'package:machine_task/app/data/services/details_api.dart';

import '../../../data/model/details_model.dart';

class ActivityDetailsController extends GetxController with StateMixin<bool> {
  final isLoading = false.obs;

  DetailsModel? detailsModel;

  final arg = 0.obs;

  @override
  Future<void> onInit() async {
    change(null, status: RxStatus.loading());
    arg.value = Get.arguments ?? 0;
    await loadDetails();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  Future<void> loadDetails() async {
    final response = await detailsAPI(id: arg.value);
    if (response == null) return;
    detailsModel = response;
  }
}
