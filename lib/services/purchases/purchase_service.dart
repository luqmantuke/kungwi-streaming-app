import 'dart:convert';

import 'package:kungwi/models/api/default_api_modal.dart';
import 'package:kungwi/models/purchases/monetization/monetization_on_model.dart';
import 'package:http/http.dart' as http;
import 'package:kungwi/models/purchases/vifurushi/vifurushi_modal.dart';
import 'package:kungwi/utilities/api/api_constant.dart';

class PurchasesService {
  Future<bool> getMonetizationStatus() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("$serverUrl/api/is_monetization_on/"));

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    final modeledResponse = MonetizationModel.fromJson(decodedResponse);

    if (modeledResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<VifurushiModal> getVifurushi() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("$serverUrl/api/fetch_vifurushi/"));

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    final modeledResponse = VifurushiModal.fromJson(decodedResponse);

    if (modeledResponse.statusCode == 200) {
      return modeledResponse;
    } else {
      return modeledResponse;
    }
  }

  Future<DefaultApiModal> buyCredit(
      String userId, double price, int creditAmount, String phoneNumber) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("$serverUrl/api/create_buy_credit_order/"));
    final requestJson = {
      'user_id': userId,
      'amount': price.toString(),
      'credit_amount': creditAmount.toString(),
      'phone_number': phoneNumber
    };
    request.fields.addAll(requestJson);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    final modeledResponse = DefaultApiModal.fromJson(decodedResponse);

    if (modeledResponse.statusCode == 200) {
      return modeledResponse;
    } else {
      return modeledResponse;
    }
  }

  Future<DefaultApiModal> buyStoryUsingToken(String userId, String storyID,
      String storyType, double price, int creditAmount) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$serverUrl/api/buy_story/"));
    request.fields.addAll({
      'user_id': userId,
      'story_id': storyID,
      'story_type': storyType,
      'amount': price.toString(),
      'token': creditAmount.toString()
    });

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    final modeledResponse = DefaultApiModal.fromJson(decodedResponse);

    if (modeledResponse.statusCode == 200) {
      return modeledResponse;
    } else {
      return modeledResponse;
    }
  }

  Future<DefaultApiModal> userPurchasedStory(
      String userId, String storyID, String storyType) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("$serverUrl/api/user_purchased_story/"));
    request.fields.addAll(
        {'user_id': userId, 'story_type': storyType, 'story_id': storyID});

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    final modeledResponse = DefaultApiModal.fromJson(decodedResponse);

    if (modeledResponse.statusCode == 200) {
      return modeledResponse;
    } else {
      return modeledResponse;
    }
  }
}
