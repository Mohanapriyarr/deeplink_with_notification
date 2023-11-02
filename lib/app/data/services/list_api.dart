import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:machine_task/app/common_views/show_toast.dart';
import 'package:machine_task/app/data/funtions/log/log.dart';
import 'package:machine_task/app/data/services/config_strings.dart';

import '../model/list_model.dart';

Future<List<Datum>?> listAPI() async {
  Client client = Client();
  String url = '$BASE_URL/users';
  try {
    var response = await client.get(Uri.parse(url));
    Log.info(info: 'list api ~ url ~ $response');
    Log.info(info: 'list api ~ response body ~ ${response.body}');

    if (response.statusCode == 200) {
      final decodeRes = listModelFromJson(response.body);
      return decodeRes.data;
    }
    return null;
  } on PlatformException catch (e) {
    Log.severe(severe: 'list api ~ platform exception ~ $e');
    showToast(message: 'Something Went Wrong');
    return null;
  } on ClientException catch (e) {
    Log.severe(severe: 'list api ~ client exception ~ $e');
    showToast(message: 'Something Went Wrong');

    return null;
  } catch (e) {
    Log.severe(severe: 'list api ~ catch error ~ $e');
    showToast(message: 'Something Went Wrong');

    return null;
  }
}
