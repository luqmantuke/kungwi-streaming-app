import 'package:http/http.dart' as http;
import 'package:kungwi/utilities/api/api_constant.dart';

Future createUpdateFirebaseService(
    String userId, String token, String device) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse("$serverUrl/api/create_update_firebase/"));
  request.fields.addAll({
    'user_id': userId,
    'token': token,
    'device': device,
  });

  http.StreamedResponse response = await request.send();
  return response.statusCode;
}
