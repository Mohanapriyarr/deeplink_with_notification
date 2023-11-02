import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:machine_task/app/data/local_storage/local_storage.dart';
import 'package:machine_task/app/routes/app_pages.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> signOutBtnOnTap() async {
    final _auth = FirebaseAuth.instance;
    _auth.signOut();
    LocalStorage.removeUserDetails();
    Get.offAllNamed(Routes.LOGIN);
  }
}
