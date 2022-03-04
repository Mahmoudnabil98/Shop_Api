import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/model/register.dart';
import 'package:shop_app/model/user.dart';

import '../constance.dart';

class AuthServices {
  // Login Funtion
  static Future<UserModel> login(
      {@required String email,
      @required password,
      @required String lang}) async {
    var response = await http.post(Uri.parse('$urlBase/login'),
        headers: {
          'lang': lang,
          'Content-Type': 'application/json',
          "Accept": "application/json",
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body));
      return userModel;
    } else {
      return throw Exception('Failed to load login');
    }
  }

  static Future<Register> register(
      {@required String name,
      @required String phone,
      @required String email,
      @required String password,
      @required String lang}) async {
    var response = await http.post(Uri.parse('$urlBase/register'),
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          'lag': lang,
        },
        body: jsonEncode({
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'image':
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      Register register = Register.fromJson(jsonDecode(response.body));
      return register;
    } else {
      return throw Exception('Failed to load register');
    }
  }

  static Future profileData(
      {@required String token, @required String lang}) async {
    var value = await http.get(Uri.parse('$urlBase/profile'), headers: {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      'lang': lang,
      'Authorization': token,
    });
    if (value.statusCode == 200 || value.statusCode == 201) {
      Map decodedata = json.decode(value.body);
      if (decodedata != null) {
        String user = jsonEncode(UserModel.fromJson(decodedata));
        return user;
      } else {
        return throw Exception('Failed to load login');
      }
    }
  }
}
