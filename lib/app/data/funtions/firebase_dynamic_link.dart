import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:machine_task/app/data/funtions/log/log.dart';
import 'package:machine_task/app/data/local_storage/local_storage.dart';

import '../../routes/app_pages.dart';

class FirebaseDynamicLinkService {
  static Future initDynamicLinkOnBackground() async {
    var event = FirebaseDynamicLinks.instance.onLink.listen((newEvent) {
      Log.info(
          info:
              'firebase listener dynamic link ~ newEvent received ~ ${newEvent.link}');
    });

    event.onData((data) async {
      Log.info(
          info:
              'firebase listener dynamic link ~ data received ~ ${data.link}');
      final Uri deepLink = data.link;

      Log.info(
          info: 'firebase dynamic link ~ deep link1 ${deepLink.pathSegments}');
      final isLoggedIn = await LocalStorage.readLoggedIn();
      if (isLoggedIn) {
        Get.toNamed(Routes.ACTIVITY_DETAILS, arguments: 2);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}
