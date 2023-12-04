import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/login_response.dart';
import '../utils/constants.dart';

class UserPref {
  Future<bool> saveAccessToken(LoginResponse loginData) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(
        KeyConstant.accessToken, loginData.accessToken);

    return true;
  }

  Future<String?> getAccessToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString(KeyConstant.accessToken);

    return token;
  }

  Future<bool> removeAccessToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();

    return true;
  }

  Future<bool> saveUser(LoginResponse loginData) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(KeyConstant.savedUser, jsonEncode(loginData));

    return true;
  }

  Future<dynamic> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var myData = sp.getString(KeyConstant.savedUser);
    var data = jsonDecode(myData!);
    return data;
  }
}