import 'package:get/get.dart';
import 'package:machine_task/app/data/services/list_api.dart';

import '../../../data/model/list_model.dart';

class ActivityListController extends GetxController with StateMixin<bool> {
  final isLoading = false.obs;

  final itemList = <Datum>[].obs;
  @override
  Future<void> onInit() async {
    change(null, status: RxStatus.loading());
    await list();
    change(null, status: RxStatus.success());

    super.onInit();
  }

  Future<void> list() async {
    final response = await listAPI();
    if (response == null) return;
    itemList.value = response;
  }
}
