import 'package:http/http.dart' as http;
import 'package:kungwi/utilities/api/api_constant.dart';
import 'dart:convert';

class AuthenticationService {
  Future signUp(
      {required String username,
      required String password,
      required String phoneNumber}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$serverUrl/api/auth/signup/'));
    request.fields.addAll({
      'username': username,
      'phone_number': phoneNumber,
      'password': password
    });

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    if (decodedResponse['status_code'] == 201) {
      return decodedResponse;
    } else {
      return decodedResponse;
    }
  }

  Future verifyUserSendOtp({required String phoneNumber}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/auth/verify_user_send_otp/'));
    request.fields.addAll({'phone_number': phoneNumber});

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    if (decodedResponse['status_code'] == 200) {
      return decodedResponse;
    } else {
      return decodedResponse;
    }
  }

  Future verifySignUpOtp(
      {required String phoneNumber, required String otp}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/auth/verify_signup_otp/'));
    request.fields.addAll({'phone_number': phoneNumber, 'otp_value': otp});

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    if (decodedResponse['status_code'] == 200) {
      return decodedResponse;
    } else {
      return decodedResponse;
    }
  }

  Future login({required String phoneNumber, required String password}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$serverUrl/api/auth/login/'));
    request.fields.addAll({'phone_number': phoneNumber, 'password': password});

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    if (decodedResponse['status_code'] == 200) {
      return decodedResponse;
    } else {
      return decodedResponse;
    }
  }

  Future resetPasswordSendOTP({required String phoneNumber}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/auth/forget_password_send_email/'));
    request.fields.addAll({'phone_number': phoneNumber});

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    if (decodedResponse['status_code'] == 200) {
      return decodedResponse;
    } else {
      return decodedResponse;
    }
  }

  Future verifyResetPasswordOtp(
      {required String phoneNumber, required String otp}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/auth/verify_forget_password_otp/'));
    request.fields.addAll({'phone_number': phoneNumber, 'otp_value': otp});

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    if (decodedResponse['status_code'] == 200) {
      return decodedResponse;
    } else {
      return decodedResponse;
    }
  }

  Future changeForgetPassword(
      {required String phoneNumber, required String password}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/auth/change_forget_password/'));
    request.fields
        .addAll({'phone_number': phoneNumber, 'new_password': password});

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    if (decodedResponse['status_code'] == 200) {
      return decodedResponse;
    } else {
      return decodedResponse;
    }
  }

  Future deleteUserAccount({required String userId}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/auth/delete_user_data/'));
    request.fields.addAll({'user_id': userId});
    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    if (decodedResponse['status_code'] == 200) {
      return decodedResponse;
    } else {
      return decodedResponse;
    }
  }
}
