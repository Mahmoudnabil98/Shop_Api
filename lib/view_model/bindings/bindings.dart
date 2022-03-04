import 'package:get/get.dart';
import 'package:shop_app/view_model/address_controller.dart';
import 'package:shop_app/view_model/auth_controller.dart';
import 'package:shop_app/view_model/cart_controller.dart';
import 'package:shop_app/view_model/favorite_controller.dart';
import 'package:shop_app/view_model/home_controller.dart';
import 'package:shop_app/view_model/network_manager.dart';
import 'package:shop_app/view_model/profile_controller.dart';
import 'package:shop_app/view_model/setting_controller.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
    Get.put<AuthController>(AuthController());
    Get.lazyPut(
      () => HomeController(),
      fenix: true,
    );
    Get.lazyPut<FavoriteController>(() => FavoriteController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<NetworkManager>(() => NetworkManager(), fenix: true);
    Get.lazyPut<AddressController>(() => AddressController(), fenix: true);
  }
}
