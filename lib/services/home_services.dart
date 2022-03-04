import 'dart:convert';
import 'package:shop_app/constance.dart';
import 'package:shop_app/model/categories.dart' as category;
import 'package:http/http.dart' as http;
import 'package:shop_app/model/product.dart';

class HomeServices {
  static Future<List<DataVal>> productData(String token, String lang) async {
    var value = await http
        .get(Uri.parse('$urlBase/products'), headers: <String, String>{
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (value.statusCode == 200) {
      Products products = Products.fromJson(jsonDecode(value.body));
      return products.data.data;
    } else {
      return throw Exception('Failed to load product');
    }
  }

  static Future<List<category.DataVal>> categoriesData(String lang) async {
    var value = await http.get(Uri.parse('$urlBase/categories'), headers: {
      'lang': lang,
      'Content-Type': 'application/json',
    });

    if (value.statusCode == 200) {
      category.Categories _categories =
          category.Categories.fromJson(jsonDecode(value.body));
      return _categories.data.data;
    } else {
      throw Exception('Failed to load product');
    }
  }

  static Future<List<DataVal>> categoriesDetals(int id, String lang) async {
    var value = await http.get(Uri.parse('$urlBase/categories/$id'), headers: {
      'lang': lang,
      'Content-Type': 'application/json',
    });
    if (value.statusCode == 200) {
      Products products = Products.fromJson(jsonDecode(value.body));
      return products.data.data;
    } else {
      return throw Exception('Failed to load product');
    }
  }
}
