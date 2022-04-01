import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:relife_god/config/api_config.dart';
import 'package:relife_god/model/get_all_user_details_model.dart';
import 'package:http/http.dart' as http;

class GetAllUsersService {
  Future<GetAllUserResponseModel?> getAllUsers(
      String token, BuildContext context) async {
    final url = Uri.http(ApiConfig.baseUrl, ApiConfig.getAllUsers);

    final response = await http.get(url, headers: {
      'Authorization': token,
    });
    log("GetAllUsers ______ ${response.body}");
    log("${response.statusCode}");
    if (response.statusCode == 200) {
      log("inside status code");
      return GetAllUserResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
