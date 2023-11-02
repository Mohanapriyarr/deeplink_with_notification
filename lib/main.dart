import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:machine_task/app/data/local_storage/local_storage.dart';
import 'package:palestine_console/palestine_console.dart';

import 'app/data/funtions/firebase_dynamic_link.dart';
import 'app/data/funtions/log/log.dart';
import 'app/routes/app_pages.dart';

final log = Logger("");

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseDynamicLinkService.initDynamicLinkOnBackground();

  //? Log everything in debug builds.  Log severe (and up) in release builds.
  Logger.root.level = kDebugMode ? Level.ALL : Level.SEVERE;
  Logger.root.onRecord.listen((record) {
    record.level.name.contains('INFO') ? Print.yellow('''
  --🚀 ${record.time}
|
  --${record.message}
''') : Print.red('🚀 ${record.time}\n~ ${record.message}');
  });

  Log.severe(severe: 'Fcm Token ~ $fcmToken');

  await LocalStorage.saveFcmToken(fcmToken ?? '');

  final isAlreadyLogin = await LocalStorage.readLoggedIn();

  Log.info(info: 'is Already Login $isAlreadyLogin');

  runApp(MainApp(isAlreadyLogin: isAlreadyLogin));
}

class MainApp extends StatelessWidget {
  final bool isAlreadyLogin;
  const MainApp({super.key, required this.isAlreadyLogin});

  @override
  Widget build(BuildContext context) {
    return FirebaseNotificationsHandler(
      onOpenNotificationArrive: ((_, payload) async {
        Log.info(
          info: "Notification received while app is open with payload $payload",
        );
        // final isLoggedIn = await LocalStorage.readLoggedIn();
        // if (isLoggedIn) {
        //   Get.toNamed(Routes.ACTIVITY_DETAILS, arguments: 2);
        // } else {
        //   Get.offAllNamed(Routes.LOGIN);
        // }
      }),
      onFCMTokenInitialize: (_, token) {
        Log.info(info: 'firebase device token ~ $token');
      },
      onFCMTokenUpdate: (_, token) {
        Log.info(info: 'firebase device token ~ $token');
      },
      onTap: (navigatorState, appState, payload) async {
        debugPrint('''
              Notification on tap event called and received payload
              $payload
              appState
              ${appState.name}
              navigator state current state
              ${navigatorState.currentState}
              ''');
        final isLoggedIn = await LocalStorage.readLoggedIn();
        if (isLoggedIn) {
          Get.toNamed(Routes.ACTIVITY_DETAILS, arguments: 2);
        } else {
          Get.offAllNamed(Routes.LOGIN);
        }
      },
      enableLogs: true,
      child: GetMaterialApp(
        title: "Application",
        initialRoute:
            isAlreadyLogin ? AppPages.BOTTOM_NAV_BAR : AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
