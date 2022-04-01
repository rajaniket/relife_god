import 'dart:convert';
import 'dart:developer';
import 'package:relife_god/config/api_config.dart';
import 'package:relife_god/model/user_habits_model.dart';
import 'package:http/http.dart' as http;

class GetUserHabitsService {
  Future<UserAllHabitsModel?> getUserHabits(String token, String userId) async {
    final url = Uri.http(
        ApiConfig.baseUrl, ApiConfig.getAllHabitsOfUserForGod + '/$userId');

    final response = await http.get(url, headers: {
      'Authorization': token,
    });
    log("GetUserHabitsService ${response.body}");
    if (response.statusCode == 200) {
      return UserAllHabitsModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
