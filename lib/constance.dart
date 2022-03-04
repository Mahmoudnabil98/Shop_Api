import 'package:flutter/material.dart';
import 'package:get/get.dart';

String urlBase = 'https://student.valuxapps.com/api';

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

final Color primaryColor = hexToColor('#64B6FF');

var lang = ['en', 'ar'].obs;
var ar = "ar".obs;
var en = "en".obs;

const initialRoute = '/';
const switchView = '/SwitchView';
const loginView = '/LoginView';
const registerView = '/RegisterView';
const homeView = '/HomeView';
const menuView = '/MenuView';
const featuredView = '/FeaturedView';
const detailsProductView = '/DetailsProductView';
const cartView = '/CartView';
const addressView = '/AddressView';
const favoriteView = '/FavoriteView';
const settingsView = '/SettingsView';
const categoryDetalsView = '/CategoryDetalsView';
const createAddressView = '/CreateAddressView';
const profileEditView = '/ProfileEditView';
const myAddressView = '/MyAddressView';

class ThemeApp {
  static final light = ThemeData.light().copyWith(
    colorScheme: ColorScheme.light(
      primary: hexToColor('#667EEA'),
      secondary: hexToColor('#64B6FF'),
    ),
    backgroundColor: hexToColor('#FFFFFF'),
    iconTheme: const IconThemeData(color: Colors.black),
    primaryColor: Colors.black,
    brightness: Brightness.light,
    buttonColor: hexToColor('#FB5895'),
    cardColor: Colors.blueAccent,
    indicatorColor: hexToColor('#FB5895'),
  );

  static final dark = ThemeData.dark().copyWith(
    indicatorColor: Colors.pinkAccent,
    cardColor: Colors.pinkAccent,
    colorScheme: ColorScheme.dark(
      primary: hexToColor('#FF5858'),
      secondary: hexToColor('#FB5895'),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    backgroundColor: const Color(0xFF212121),
    buttonColor: Colors.pinkAccent,
    iconTheme: const IconThemeData(color: Colors.white),
    primaryColor: Colors.white,
    brightness: Brightness.dark,
  );
}
