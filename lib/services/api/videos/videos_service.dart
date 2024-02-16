import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kungwi/models/videos/videos_model.dart';
import 'package:kungwi/utilities/api/api_constant.dart';

Future<VideosModel> getTrendingVideos() async {
  var request = http.MultipartRequest(
      'POST', Uri.parse("$serverUrl/api/fetch_trending_videos/"));

  http.StreamedResponse response = await request.send();
  var responseString = await response.stream.bytesToString();
  var decodedResponse = json.decode(responseString);
  final modeledResponse = VideosModel.fromJson(decodedResponse);
  if (modeledResponse.statusCode == 200) {
    return modeledResponse;
  } else {
    return modeledResponse;
  }
}

Future<VideosModel> getAllVideos() async {
  var request = http.MultipartRequest(
      'POST', Uri.parse("$serverUrl/api/fetch_all_videos/"));

  http.StreamedResponse response = await request.send();
  var responseString = await response.stream.bytesToString();
  var decodedResponse = json.decode(responseString);
  final modeledResponse = VideosModel.fromJson(decodedResponse);
  if (modeledResponse.statusCode == 200) {
    return modeledResponse;
  } else {
    return modeledResponse;
  }
}
