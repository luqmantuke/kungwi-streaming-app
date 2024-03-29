///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class UserProfileModelData {
/*
{
  "id": 2,
  "username": "luqman",
  "phone_number": "255758585847",
  "credits": 1400
} 
*/

  int? id;
  String? username;
  String? phoneNumber;
  int? credits;

  UserProfileModelData({
    this.id,
    this.username,
    this.phoneNumber,
    this.credits,
  });
  UserProfileModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    phoneNumber = json['phone_number']?.toString();
    credits = json['credits']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['phone_number'] = phoneNumber;
    data['credits'] = credits;
    return data;
  }
}

class UserProfileModel {
/*
{
  "status": "success",
  "message": "User Fetched successfully",
  "status_code": 200,
  "data": {
    "id": 2,
    "username": "luqman",
    "phone_number": "255758585847",
    "credits": 1400
  }
} 
*/

  String? status;
  String? message;
  int? statusCode;
  UserProfileModelData? data;

  UserProfileModel({
    this.status,
    this.message,
    this.statusCode,
    this.data,
  });
  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    statusCode = json['status_code']?.toInt();
    data = (json['data'] != null)
        ? UserProfileModelData.fromJson(json['data'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['status_code'] = statusCode;
    data['data'] = this.data!.toJson();
    return data;
  }
}
