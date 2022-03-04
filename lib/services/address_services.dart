import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/model/address.dart';

import '../constance.dart';

class AddressServices {
  static Future<List<AddressData>> getAddress(String token) async {
    var response = await http.get(Uri.parse('$urlBase/addresses'), headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      Address address = Address.fromJson(jsonDecode(response.body));
      log(' addressData ${address.data.addressData.length}');
      return address.data.addressData;
    } else {
      log('error ');
      return throw Exception('Failed to load address');
    }
  }

  static Future<Address> addAddress(
      {@required String token,
      @required String name,
      @required String city,
      @required String region,
      @required String details,
      @required String latitude,
      @required String longitude,
      @required String notes}) async {
    var response = await http.post(Uri.parse('$urlBase/addresses'),
        headers: {
          'lang': 'en',
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          "name": name,
          "city": city,
          "region": region,
          "details": details,
          "latitude": latitude,
          "longitude": longitude,
          "notes": notes
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      Address address = Address.fromJson(jsonDecode(response.body));
      return address;
    } else {
      log('error ');
      return throw Exception('Failed to load favorites');
    }
  }
}
