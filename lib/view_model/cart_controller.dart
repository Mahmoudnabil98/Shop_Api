import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as box;
import 'package:shop_app/model/cart.dart';
import 'package:shop_app/services/cart_services.dart';

import '../constance.dart';

class CartController extends GetxController {
  RxList<CartItems> cartlist = <CartItems>[].obs;
  final _keyLangauge = 'langauge';

  var isLoadingCart = false.obs;
  var isLoadingAddCart = false.obs;
  var isloadingDelete = false.obs;
  var totalAmount = 0.obs;
  var inCart = false.obs;
  var lang = ''.obs;

  Rxn<Data> data = Rxn<Data>();
  Cart cartmodel;
  final _box = box.GetStorage();
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) => getCart());
    lang.value = getlangauge() ?? 'en';
    super.onInit();
  }

  String getlangauge() {
    return _box.read(_keyLangauge) ?? "en";
  }

  Future<String> getToken() async {
    var storage = const FlutterSecureStorage();
    String token = await storage.read(key: 'Token');
    return token;
  }

  Future<void> getCart() async {
    isLoadingCart(true);
    try {
      String token = await getToken();
      var value = await CartServices.getCartProduct(token, lang.value);

      if (value != null) {
        cartlist.value = value.cartItems;
        data.value = value;
      }
    } finally {
      update();
      isLoadingCart(false);
    }
  }

  void deleteItem(int index) {
    cartlist.removeAt(index);
    update();
  }

  Future<void> addCartProduct(
      {@required num id, @required BuildContext context}) async {
    isLoadingAddCart(true);
    try {
      String token = await getToken();
      cartmodel =
          await CartServices.addCart(id: id, token: token, lang: lang.value)
              .catchError((error) {
        inCart.value = !inCart.value;
        showToast(
          '${cartmodel.message}',
          context: context,
          backgroundColor:
              Get.isDarkMode ? Colors.pinkAccent : hexToColor('#667EEA'),
        );
        // ignore: missing_return
      });
      showToast(
        cartmodel.message,
        context: context,
        backgroundColor:
            Get.isDarkMode ? Colors.pinkAccent : hexToColor('#667EEA'),
      );

      log("cart ${cartmodel.message}");
    } finally {
      getCart();
      update();
      isLoadingAddCart(false);
    }
  }

  quantityAdd(CartItems cart) {
    cart.quantity++;
    _totalAmountGet();
    update();
  }

  quantityMinus(CartItems cart) {
    if (cart.quantity > 0) {
      cart.quantity--;
      _totalAmountGet();
      update();
    }
  }

  _totalAmountGet() {
    totalAmount.value = cartlist.fold(0,
        (previous, current) => previous + current.quantity * current.quantity);
  }
}
