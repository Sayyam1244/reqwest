import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:reqwest/SRC/Application/Services/ApiServices/api_exceptions.dart';

typedef MapBody = Map<String, dynamic>;

class ApiServices {
  ApiServices._privateConstructor();
  static final ApiServices instance = ApiServices._privateConstructor();

  Future postApi({
    required String url,
    required MapBody body,
  }) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      String? token = user != null ? await user.getIdToken() : null;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http
          .post(Uri.parse(url), body: jsonEncode(body), headers: headers)
          .timeout(const Duration(seconds: 20));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      if (response.statusCode == 404) {
        try {
          return jsonDecode(response.body);
        } catch (e) {
          return response.reasonPhrase;
        }
      } else {
        return response.reasonPhrase;
      }
    } catch (e) {
      return ExceptionHandler.handleApiException(e);
    }
  }
}
