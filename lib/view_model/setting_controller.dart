import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'bindings/bindings.dart';

class SettingController extends GetxController {
  var lang = ''.obs;
  final _key = 'isDarkMode';
  final _keyLangauge = 'langauge';

  final _box = GetStorage();

  @override
  void onInit() {
    lang.value = getlangauge();
    changeLangauge(lang.value);
    // TODO: implement onInit
    super.onInit();
  }

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Switch theme and save to local storage
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }

  void saveLangauge(String value) async {
    await GetStorage.init();
    _box.write(_keyLangauge, value);
  }

  String getlangauge() {
    return _box.read(_keyLangauge) ?? "en";
  }

  void changeLangauge(String value) {
    saveLangauge(value);
    if (lang.value == value) {
      return;
    } else if (lang.value == "en") {
      saveLangauge('en');
    } else if (lang.value == "ar") {
      saveLangauge('ar');
    } else {
      saveLangauge('en');
    }
    update();
    Get.resetRootNavigator();
    Binding();
  }
}
