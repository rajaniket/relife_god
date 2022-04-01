import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relife_god/model/login_model.dart';
import 'package:relife_god/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isloginSuccess = false;
  String _message = '';
  String _firstName = '';
  String _userId = '';
  LoginResponseModel? responseModel;
  LoginRequestModel requestModel =
      LoginRequestModel(email: 'email', password: 'password');

  bool get isLoading => _isLoading;
  String get message => _message;
  String get firstName => _firstName;
  String get userId => _userId;
  bool get isLoginSuccess => _isloginSuccess;

  Future<bool> login(BuildContext context) async {
    setLoading(true);
    responseModel = await ApiService().login(requestModel);

    if (responseModel!.message == '') {
      setMessage('Login SuccessFul');
      await setSharedService();
      final String token =
          responseModel!.details['token'].toString().split(' ')[1];
      setFirstName(responseModel!.details['name']);
      setUserId(responseModel!.details['userId']);

      setLoginSuccess(true);
      // await GetSystemHabitsService().getSystemHabit(token);
      setLoading(false);
    } else {
      setLoginSuccess(false);
      setMessage(responseModel!.message!);
      setLoading(false);
    }

    notifyListeners();
    return _isloginSuccess;
  }

  Future<void> logOut() async {
    await removeSharedService();

    return;
  }

  Future<void> setSharedService() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('token', responseModel!.details['token']);
    sharedPreferences.setString('userId', responseModel!.details['userId']);
  }

  Future<void> removeSharedService() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    sharedPreferences.remove('userId');
    sharedPreferences.remove('isPostedToday');
  }

  void setMessage(String value) {
    _message = value;
    notifyListeners();
  }

  Future<String?> getUserId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('userId');
  }

  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setUserId(String value) {
    _userId = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setLoginSuccess(bool value) {
    _isloginSuccess = value;
    notifyListeners();
  }
}
