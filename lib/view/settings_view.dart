import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view/widgets/language_widget.dart';
import 'package:shop_app/view_model/setting_controller.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const Icon(Icons.arrow_back),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(
                    fontSize: 14,
                    text:
                        'Change to ${SettingController().theme != ThemeMode.dark ? 'Dark Mode' : 'Light Mode'}'
                            .tr,
                  ),
                  ElevatedButton(
                    onPressed: SettingController().switchTheme,
                    child: CustomText(
                      color: Colors.white,
                      text: SettingController().theme != ThemeMode.dark
                          ? "Dark Mode".tr
                          : 'Light Mode'.tr,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              LanguageWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
