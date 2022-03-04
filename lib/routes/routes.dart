import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view/address_view/address_view.dart';
import 'package:shop_app/view/address_view/create_address_view.dart';
import 'package:shop_app/view/address_view/my_address_view.dart';
import 'package:shop_app/view/cart_view.dart';
import 'package:shop_app/view/categorydetals_view.dart';
import 'package:shop_app/view/details_product_view.dart';
import 'package:shop_app/view/favorite_view.dart';
import 'package:shop_app/view/featured_view.dart';
import 'package:shop_app/view/home_view.dart';
import 'package:shop_app/view/login_view.dart';
import 'package:shop_app/view/menu_view.dart';
import 'package:shop_app/view/profile_edit_view.dart';
import 'package:shop_app/view/register_vew.dart';
import 'package:shop_app/view/settings_view.dart';
import 'package:shop_app/view/splash_view.dart';
import 'package:shop_app/view/switch_view.dart';
import 'package:shop_app/view_model/bindings/bindings.dart';

List<GetPage> routes = [
  GetPage(
    name: initialRoute,
    page: () => SplashView(),
    binding: Binding(),
    transition: Transition.leftToRightWithFade,
  ),
  GetPage(
      name: switchView,
      page: () => SwitchView(),
      binding: Binding(),
      transition: Transition.leftToRight),
  GetPage(
      name: loginView,
      page: () => LoginView(),
      transition: Transition.leftToRight),
  GetPage(
      name: registerView,
      page: () => RegisterView(),
      transition: Transition.leftToRight),
  GetPage(
      name: homeView,
      page: () => HomeView(),
      binding: Binding(),
      transition: Transition.leftToRight),
  GetPage(
      name: menuView,
      page: () => MenuView(),
      transition: Transition.leftToRight),
  GetPage(
      name: featuredView,
      page: () => FeaturedView(),
      transition: Transition.leftToRight),
  GetPage(
      name: detailsProductView,
      page: () => DetailsProductView(),
      transition: Transition.leftToRight),
  GetPage(
      name: cartView,
      page: () => CartView(),
      transition: Transition.leftToRight),
  GetPage(
      name: addressView,
      page: () => AddressView(),
      transition: Transition.leftToRight),
  GetPage(
      name: favoriteView,
      page: () => FavoriteView(),
      transition: Transition.leftToRight),
  GetPage(
      name: myAddressView,
      page: () => MyAddressView(),
      transition: Transition.leftToRight),
  GetPage(
      name: profileEditView,
      page: () => ProfileEditView(),
      transition: Transition.leftToRight),
  GetPage(
      name: createAddressView,
      page: () => CreateAddressView(),
      transition: Transition.leftToRight),
  GetPage(
      name: categoryDetalsView,
      page: () => CategoryDetalsView(),
      transition: Transition.leftToRight),
  GetPage(
      name: settingsView,
      page: () => SettingsView(),
      transition: Transition.leftToRight)
];
