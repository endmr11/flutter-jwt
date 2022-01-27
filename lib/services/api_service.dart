import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwtlogresflutter/env/config.dart';
import 'package:jwtlogresflutter/models/login_request_model.dart';
import 'package:jwtlogresflutter/models/login_response_model.dart';
import 'package:jwtlogresflutter/models/register_request_model.dart';
import 'package:jwtlogresflutter/models/register_response_model.dart';
import 'package:jwtlogresflutter/services/shared_service.dart';

class APIService {
  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(EnvConfig.apiURL + EnvConfig.loginAPI);

    var response = await http.post(url, headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      await SharedService.setLoginDetail(loginResponseModelFromJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(EnvConfig.apiURL + EnvConfig.registerAPI);
    var response = await http.post(url, headers: requestHeaders, body: jsonEncode(model.toJson()));

    return registerResponseModelFromJson(response.body);
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Basic ${loginDetails!.data!.token}'};

    var url = Uri.parse(EnvConfig.apiURL + EnvConfig.userProfileAPI);

    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
