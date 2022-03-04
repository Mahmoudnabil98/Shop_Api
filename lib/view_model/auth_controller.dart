import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/model/register.dart';
import 'package:shop_app/model/user.dart';
import 'package:shop_app/services/auth_services.dart';
import '../constance.dart';
import 'bindings/bindings.dart';

class AuthController extends GetxController {
  //Varibale
  final keyRegister = GlobalKey<FormState>();
  final keyLogin = GlobalKey<FormState>();

  String name, phone, email, password;
  var isObscure = true.obs;
  var isLoading = false.obs;
  var isLoadingProfile = false.obs;
  String token;
  UserModel userModel;
  Register register;
  final _keyLangauge = 'langauge';

  var lang = ''.obs;

  final _box = GetStorage();

  @override
  void onInit() async {
    token = await getToken();
    profileData();
    super.onInit();
  }

  @override
  void onReady() {
    lang.value = getlangauge();
    super.onReady();
  }

  String getlangauge() {
    return _box.read(_keyLangauge) ?? "en";
  }

  // Password obscure
  void obscure() {
    isObscure.value = !isObscure.value;
    update();
  }

  //  Token save
  void saveToken(String value) async {
    var storage = const FlutterSecureStorage();
    await storage.write(key: 'Token', value: value);
  }

  // User Token
  Future<String> getToken() async {
    var storage = const FlutterSecureStorage();
    var value = await storage.read(key: 'Token');
    return value;
  }

  //  validator
  validator(String value) {
    if (value.isEmpty || value == null) {
      return 'There is an error in the data';
    }
    return null;
  }

// save data User
  Future<void> setUserData(String user) async {
    SharedPreferences value = await SharedPreferences.getInstance();
    await value.setString('User', user).then((value) {
      log("user ${value}");
    });
  }

  //get data User
  Future<UserModel> getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map userMap = jsonDecode(preferences.getString('User'));
    UserModel.fromJson(userMap);
    return UserModel.fromJson(userMap);
  }

  // register Function
  Future<void> registerFn(BuildContext context) async {
    isLoading(true);
    try {
      register = await AuthServices.register(
          name: name,
          phone: phone,
          email: email,
          password: password,
          lang: lang.value);
      if (register.status == true) {
        saveToken(register.data.token);
        showToast(
          register.message,
          context: context,
          backgroundColor: hexToColor('#667EEA'),
        );
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.offNamed(loginView);
        });
      } else if (register.status == false) {
        showToast(
          register.message,
          context: context,
          backgroundColor: Colors.redAccent,
        );
      }
    } finally {
      isLoading(false);
    }
  }

  // Login Funtion
  Future<void> login(BuildContext context) async {
    isLoading.value = true;

    try {
      UserModel userModel = await AuthServices.login(
          email: email, password: password, lang: lang.value);

      if (userModel.status == true) {
        String user = jsonEncode(userModel);
        setUserData(user);
        saveToken(userModel.data.token);
        showToast(
          '${userModel.message}',
          context: context,
          backgroundColor: hexToColor('#667EEA'),
        );
        Get.offNamed(homeView, arguments: Binding());
      } else if (userModel.status == false) {
        showToast(
          '${userModel.message}',
          context: context,
          backgroundColor: Colors.redAccent,
        );
      }
    } finally {
      profileData();
      isLoading(false);
    }
  }

// profile Data Function
  Future<void> profileData() async {
    isLoadingProfile(true);
    String token = await getToken();
    try {
      String value =
          await AuthServices.profileData(token: token, lang: lang.value);
      setUserData(value);
    } finally {
      userModel = await getUserData();
      isLoadingProfile(false);
    }
  }

  Future<void> logOut() async {
    SharedPreferences value = await SharedPreferences.getInstance();
    var storage = const FlutterSecureStorage();
    await storage.deleteAll().then((value) {
      log('token delete');
    });
    await value.clear().then((value) {
      log('clear ${value}');
    });
    Get.offAllNamed('/SwitchView').then((value) {
      log('clear ${value}');
    });
  }
}
