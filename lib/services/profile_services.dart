import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shop_app/constance.dart';
import 'package:shop_app/model/user.dart';

class PorfileServies {
  static Future<UserModel> updateProfileServies(
      {String name, password, phone, email, token}) async {
    var response =
        await http.post(Uri.parse('$urlBase/update-profile'), headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    }, body: {
      {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
        "image":
            "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"
      }
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body));
      return userModel;
    } else {
      log('error edit profile ');
      return throw Exception('Failed to load edit profile');
    }
  }
}
