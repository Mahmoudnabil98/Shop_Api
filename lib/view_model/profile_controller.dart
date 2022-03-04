import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/model/user.dart';
import 'package:shop_app/services/profile_services.dart';

class ProfileController extends GetxController {
  String name, password, phone, email;
  var isloadingProfile = false.obs;

  final keyPro = GlobalKey<FormState>();

  UserModel userModel;

  String validator(String value) {
    if (value.isEmpty || value.length <= 6) {
      return 'Password is less than 6 characters';
    } else {
      return null;
    }
  }

  Future<String> getToken() async {
    var storage = const FlutterSecureStorage();
    String token = await storage.read(key: 'Token');
    return token;
  }

  Future<void> edtProfileContol(BuildContext context) async {
    isloadingProfile(true);
    try {
      String token = await getToken();
      userModel = await PorfileServies.updateProfileServies(
          email: email,
          phone: phone,
          password: password,
          name: name,
          token: token);
    } finally {
      isloadingProfile(false);
      showToast(
        '${userModel.message}',
        context: context,
        backgroundColor: hexToColor('#667EEA'),
      );
    }
  }
}
