import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/model/categories.dart';
import 'package:shop_app/model/favorites.dart';
import 'package:shop_app/model/product.dart' as data;
import 'package:shop_app/services/favorite_services.dart';
import 'package:shop_app/services/home_services.dart';
import 'package:shop_app/view_model/favorite_controller.dart';

class HomeController extends GetxController {
  var icon = false.obs;
  var list = <data.DataVal>[].obs;
  var listCategory = <DataVal>[].obs;
  var listCategoryDetals = <data.DataVal>[].obs;
  var listFavorit = <data.DataVal>[].obs;
  Iterable<data.DataVal> listDiscount = <data.DataVal>[].obs;
  var lang = 'en'.obs;
  final _keyLangauge = 'langauge';
  Categories categories;
  FavoriteController favoriteController;

  //Favorites
  var favorites = <int, bool>{}.obs;
  Favorites favorite;

// loading ///
  var isloadingProduct = false.obs;
  var isloadingCategoryDetals = false.obs;
  var isloadingCategory = false.obs;
  var isloadingfavorites = false.obs;
  var isloadingSearch = false.obs;
  var isLoadingDiscount = false.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /// switch ///

//search
  var listSearch = <data.DataVal>[].obs;
  TextEditingController textEditingController = TextEditingController();

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    productData();
    lang.value = getlangauge();
    super.onInit();
  }

  final _box = GetStorage();

  String getlangauge() {
    return _box.read(_keyLangauge) ?? "en";
  }

  Future getToken() async {
    var storage = const FlutterSecureStorage();
    String token = await storage.read(key: 'Token');
    return token;
  }

  Future<void> productData() async {
    isloadingProduct(true);
    String token = await getToken();
    var value = await HomeServices.productData(token, lang.value);
    try {
      if (value.isNotEmpty) {
        list.value = value;
        value.map((element) {
          favorites.addAll({element.id: element.inFavorites});
        }).toList();
      } else {
        throw Exception('error load Data');
      }
    } finally {
      productDiscount();
      refreshController.refreshCompleted();
      isloadingProduct(false);
    }
  }

  Future<void> categoriesData() async {
    isloadingCategory(true);
    var value = await HomeServices.categoriesData(lang.value);

    try {
      if (value.isNotEmpty) {
        listCategory.value = value;
      } else {
        throw Exception('error load Data Categry');
      }
    } finally {
      refreshController.refreshCompleted();
      isloadingCategory(false);
    }
  }

  Future<void> categoriesDetals({int id}) async {
    isloadingCategoryDetals(true);
    var value = await HomeServices.categoriesDetals(id, lang.value);
    try {
      if (value.isNotEmpty) {
        listCategoryDetals.value = value;
      } else {
        throw Exception('error load Data Categry');
      }
    } finally {
      refreshController.refreshCompleted();
      isloadingCategoryDetals(false);
    }
  }

  Future<void> addfavoriteService(int id, BuildContext context) async {
    isloadingfavorites(true);
    String token = await getToken();
    try {
      favorites[id] = !favorites[id];
      favorite = await FavoriteService.addFavorites(
              id: id, token: token, lang: lang.value)
          .catchError((error) {
        favorites[id] = !favorites[id];
        showToast(
          favorite.message,
          context: context,
          backgroundColor:
              Get.isDarkMode ? Colors.pinkAccent : hexToColor('#667EEA'),
        );
      });

      if (favorite.status = false) {
        favorites[id] == !favorites[id];
      }
      showToast(
        favorite.message,
        context: context,
        backgroundColor:
            Get.isDarkMode ? Colors.pinkAccent : hexToColor('#667EEA'),
      );
    } finally {
      update();
      isloadingfavorites(false);
    }
  }

  void productDiscount() {
    isLoadingDiscount(true);
    try {
      listDiscount = list.where((value) => value.discount > 0);
    } finally {
      isLoadingDiscount(false);
    }
    update();
  }

  void productSearch(String name) {
    name = name.toLowerCase();
    listSearch.value = list.where((search) {
      var valueName = search.name.toLowerCase();
      var valuePrice = search.price.toString().toLowerCase();
      return valueName.contains(name) || valuePrice.contains(name);
    }).toList();

    update();
  }

  void searchClear(BuildContext context) {
    textEditingController.clear();
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    productSearch('');
  }

  void switchvalue() {
    icon.value = !icon.value;
  }

  Future<void> isConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        update();
        productData();
        categoriesData();
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
