import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/model/favorites.dart';
import 'package:shop_app/services/favorite_services.dart';

class FavoriteController extends GetxController {
  var lang = ''.obs;
  var isloadingFavorite = false.obs;
  final _keyLangauge = 'langauge';

  var listFavorite = <FavData>[].obs;
  final _box = GetStorage();

  @override
  onReady() {
    getFavorite();
    lang.value = getlangauge() ?? 'en';
    super.onReady();
  }

  Future<String> getToken() async {
    var storage = const FlutterSecureStorage();
    String token = await storage.read(key: 'Token');
    return token;
  }

  String getlangauge() {
    return _box.read(_keyLangauge) ?? "en";
  }

  Future<void> getFavorite() async {
    isloadingFavorite(true);
    try {
      String token = await getToken();
      var value =
          await FavoriteService.getFavorites(token: token, lang: lang.value);
      log(" length ${value.length}");
      if (value.isNotEmpty) {
        listFavorite.value = value;
      }
    } finally {
      isloadingFavorite(false);
    }
  }
}
