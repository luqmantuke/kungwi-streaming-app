import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:kungwi/models/profile/user_profile_model.dart';
import 'package:kungwi/utilities/api/api_constant.dart';

Future<int> getUserCredit(String userId) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse("$serverUrl/api/fetch_user_profile/"));
  request.fields.addAll({
    'user_id': userId,
  });

  http.StreamedResponse response = await request.send();
  var responseString = await response.stream.bytesToString();
  var decodedResponse = json.decode(responseString);
  final modeledResponse = UserProfileModel.fromJson(decodedResponse);
  debugPrint(decodedResponse.toString());
  if (modeledResponse.statusCode == 200) {
    return modeledResponse.data?.credits ?? 0;
  } else {
    return 0;
  }
}
