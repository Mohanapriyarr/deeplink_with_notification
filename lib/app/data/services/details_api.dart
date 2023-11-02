import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:machine_task/app/data/funtions/log/log.dart';
import 'package:machine_task/app/data/services/config_strings.dart';

import '../../common_views/show_toast.dart';
import '../model/details_model.dart';

Future<DetailsModel?> detailsAPI({required int id}) async {
  Client client = Client();
  String url = '$BASE_URL/users?id=$id';
  try {
    var response = await client.get(Uri.parse(url));
    Log.info(info: 'detail api ~ url ~ $response');
    Log.info(info: 'detail api ~ response body ~ ${response.body}');

    if (response.statusCode == 200) {
      final decodeRes = detailsModelFromJson(response.body);
      return decodeRes;
    }
    return null;
  } on PlatformException catch (e) {
    Log.severe(severe: 'detail api ~ platform exception ~ $e');
    showToast(message: 'Something Went Wrong');
    return null;
  } on ClientException catch (e) {
    Log.severe(severe: 'detail api ~ client exception ~ $e');
    showToast(message: 'Something Went Wrong');

    return null;
  } catch (e) {
    Log.severe(severe: 'detail api ~ catch error ~ $e');
    showToast(message: 'Something Went Wrong');

    return null;
  }
}
