import 'package:shared_preferences/shared_preferences.dart';

class LocalKeys {
  final FCM_TOKEN = 'fcmToken';
  final ISLOGGEDIN = 'isLogin';
}

class LocalStorage {
  //? ///////////////////// SAVE LOCALLY ///////////////////

  static Future<void> saveFcmToken(String token) async {
    final _pref = await SharedPreferences.getInstance();
    _pref.setString(LocalKeys().FCM_TOKEN, token);
  }

  static Future<void> saveIsLoggedIn(bool isLogin) async {
    final _pref = await SharedPreferences.getInstance();
    _pref.setBool(LocalKeys().ISLOGGEDIN, isLogin);
  }
  

  //? ///////////////////// READ LOCALLY ///////////////////
  static Future<String> readFcmToken() async {
    final _pref = await SharedPreferences.getInstance();
    return _pref.getString(LocalKeys().FCM_TOKEN) ?? '';
  }

  static Future<bool> readLoggedIn() async {
    final _pref = await SharedPreferences.getInstance();
    return _pref.getBool(LocalKeys().ISLOGGEDIN) ?? false;
  }

  //? ///////////////////// REMOVE LOCALLY ///////////////////

  static Future<void> removeFcmToken() async {
    final _pref = await SharedPreferences.getInstance();
    _pref.remove(LocalKeys().FCM_TOKEN);
  }

  static Future<void> removeIsLoggedIn() async {
    final _pref = await SharedPreferences.getInstance();
    _pref.remove(LocalKeys().ISLOGGEDIN);
  }

  static Future<void> removeUserDetails() async {
    removeIsLoggedIn();
  }
}
