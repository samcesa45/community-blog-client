import 'dart:convert';

import 'package:user_repository/src/models/api_response.dart';
import 'package:user_repository/src/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

const baseUrl = 'http://10.0.2.2:8000/api/v1';

class UserRepository {
  final ApiResponse apiResponse = ApiResponse();
  ApiResponse? _user;

  Future<ApiResponse> getUserDetails() async {
    try {
      String token = await getToken();
      final response = await http.get(Uri.parse('$baseUrl/user'), headers: {
        'Accept': 'Application/json',
        'Authorization': 'Bearer $token'
      });
      switch (response.statusCode) {
        case 200:
          if (_user != null) return _user!;
          apiResponse.data = User.fromJson(jsonDecode(response.body));
          break;
        case 401:
          apiResponse.error = 'unauthorized';
          break;
        default:
          apiResponse.error = 'something went wrong';
      }
    } catch (e) {
      apiResponse.error = 'server error';
    }
    return apiResponse;
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }

  Future<int> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('user_id') ?? 0;
  }

  String? getStringImage(File? file) {
    if (file == null) return null;
    return base64Encode(file.readAsBytesSync());
  }
}
