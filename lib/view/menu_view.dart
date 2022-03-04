import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view_model/address_controller.dart';
import 'package:shop_app/view_model/cart_controller.dart';
import 'package:shop_app/view_model/favorite_controller.dart';
import 'package:shop_app/view_model/home_controller.dart';
import 'package:shop_app/view_model/auth_controller.dart';

// ignore: must_be_immutable
class MenuView extends StatelessWidget {
  AuthController control = Get.find();
  HomeController controller = Get.find();
  FavoriteController favoriteController = Get.find();
  CartController cartController = Get.find();

  MenuView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => control.isLoadingProfile.value == true
                  ? const CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () {
                        Get.toNamed('/ProfileEditView');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // CachedNetworkImage(
                          //   imageUrl: control.userModel.data.image,
                          //   imageBuilder: (context, imageProvider) => Container(
                          //     width: 80.0.w,
                          //     height: 80.0.h,
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       image: DecorationImage(
                          //           image: imageProvider, fit: BoxFit.cover),
                          //     ),
                          //   ),
                          //   placeholder: (context, url) =>
                          //       const CircularProgressIndicator(),
                          //   errorWidget: (context, url, error) => SizedBox(
                          //     width: 80.0.w,
                          //     height: 80.0.h,
                          //     child: error ?? const Icon(Icons.error),
                          //   ),
                          // ),
                          Column(
                            children: [
                              CustomText(
                                text: control.userModel.data.email.isEmpty
                                    ? 'UserName'
                                    : control.userModel.data.name.toString(),
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              CustomText(
                                text: control.userModel.data.email.isEmpty
                                    ? 'Email'
                                    : control.userModel.data.email.toString(),
                                fontSize: 16.sp,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/HomeView');
                      },
                      child: Text(
                        'Home'.tr,
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.pinkAccent : Colors.black,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/ProfileEditView');
                      },
                      child: Text(
                        'Profile'.tr,
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.pinkAccent : Colors.black,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/CartView');
                        cartController.getCart();
                      },
                      child: Text(
                        'My Cart'.tr,
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.pinkAccent : Colors.black,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(favoriteView);
                        favoriteController.getFavorite();
                      },
                      child: Text(
                        'Favorite'.tr,
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.pinkAccent : Colors.black,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'My Orders'.tr,
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.pinkAccent : Colors.black,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(myAddressView);
                      },
                      child: Text(
                        'My Address'.tr,
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.pinkAccent : Colors.black,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(settingsView);
                      },
                      child: Text(
                        'Settings'.tr,
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.pinkAccent : Colors.black,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        control.logOut();
                      },
                      child: Text(
                        'LogOut'.tr,
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.pinkAccent : Colors.black,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon: const Icon(
            Icons.cancel_outlined,
            size: 35,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }
}
