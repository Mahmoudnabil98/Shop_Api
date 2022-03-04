import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/model/cart.dart';
import 'package:http/http.dart' as http;

class CartServices {
  // ignore: missing_return
  static Future<Data> getCartProduct(String token, String lang) async {
    var response = await http.get(Uri.parse('$urlBase/carts'), headers: {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
    });

    if (response.statusCode == 200) {
      Cart cart = Cart.fromJson(jsonDecode(response.body));
      if (cart.status == true || cart.data.cartItems.length != null) {
        return cart.data;
      }
    } else {
      log('error ');
      return throw Exception('Failed to load favorites');
    }
  }

  static Future<Cart> addCart(
      {@required int id, @required String token, @required String lang}) async {
    var response = await http.post(Uri.parse('$urlBase/carts'),
        headers: {
          'lang': lang,
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({"product_id": id}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      Cart cart = Cart.fromJson(jsonDecode(response.body));
      return cart;
    } else {
      log('error ');
      return throw Exception('Failed to load Cart');
    }
  }
}
