import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/model/favorites.dart';
import '../constance.dart';

class FavoriteService {
  static Future<Favorites> addFavorites(
      {@required int id, @required String token, @required String lang}) async {
    var response = await http.post(Uri.parse('$urlBase/favorites'),
        headers: {
          'lang': lang,
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({"product_id": id}));
    log('${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      Favorites favorites = Favorites.fromJson(jsonDecode(response.body));
      return favorites;
    } else {
      log('error ');
      return throw Exception('Failed to load favorites');
    }
  }

  static Future<List<FavData>> getFavorites(
      {@required String token, @required String lang}) async {
    var response = await http
        .get(Uri.parse('$urlBase/favorites'), headers: <String, String>{
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      Favorites favorites = Favorites.fromJson(jsonDecode(response.body));
      return favorites.data.data;
    } else {
      log('error fav');
      return throw Exception('Failed to load favorites');
    }
  }
}
