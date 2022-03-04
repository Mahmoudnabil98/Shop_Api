import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/view/widgets/custom_button.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view_model/auth_controller.dart';

// ignore: must_be_immutable
class SwitchView extends StatelessWidget {
  AuthController authModel = Get.find();

  SwitchView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    log("${authModel.token}");

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Get.isDarkMode
            ? const Color(0xFF212121)
            : Theme.of(context).backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'Welcome to '.tr,
                      color: Colors.black54,
                      fontSize: 22.h,
                    ),
                    CustomText(
                      text: 'Bolt',
                      color: Colors.black54,
                      fontSize: 22.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  text: 'Explore Us',
                  color: Colors.black54,
                  fontSize: 18.sp,
                ),
                SizedBox(
                  height: 150.h,
                ),
                Image.asset(
                  'assets/images/Image.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 120.h),
                CustomButton(
                  text: 'Log in'.tr,
                  fontSize: 16.sp,
                  onPressed: () {
                    Get.toNamed('/LoginView');
                  },
                ),
                SizedBox(height: 10.h),
                TextButton(
                    onPressed: () {
                      Get.offNamed('/RegisterView');
                    },
                    child: CustomText(
                      text: 'Sign up'.tr,
                      fontSize: 16.sm,
                      color: Colors.black87,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
