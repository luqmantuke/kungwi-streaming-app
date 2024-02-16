import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kungwi/models/series/series_model.dart';

import 'package:kungwi/utilities/api/api_constant.dart';

Future<SeriesModel> getTrendingSeries() async {
  var request = http.MultipartRequest(
      'POST', Uri.parse("$serverUrl/api/fetch_trending_series/"));

  http.StreamedResponse response = await request.send();
  var responseString = await response.stream.bytesToString();
  var decodedResponse = json.decode(responseString);
  final modeledResponse = SeriesModel.fromJson(decodedResponse);
  if (modeledResponse.statusCode == 200) {
    return modeledResponse;
  } else {
    return modeledResponse;
  }
}

Future<SeriesModel> getAllSeries() async {
  var request = http.MultipartRequest(
      'POST', Uri.parse("$serverUrl/api/fetch_all_series/"));

  http.StreamedResponse response = await request.send();
  var responseString = await response.stream.bytesToString();
  var decodedResponse = json.decode(responseString);
  final modeledResponse = SeriesModel.fromJson(decodedResponse);
  if (modeledResponse.statusCode == 200) {
    return modeledResponse;
  } else {
    return modeledResponse;
  }
}
