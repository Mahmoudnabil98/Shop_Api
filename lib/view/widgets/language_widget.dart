import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view_model/home_controller.dart';
import 'package:shop_app/view_model/setting_controller.dart';

// ignore: use_key_in_widget_constructors
class LanguageWidget extends StatelessWidget {
  SettingController settingController = Get.find();
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.language),
          CustomText(
            text: 'Language'.tr,
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: Get.isDarkMode ? Colors.pinkAccent : primaryColor,
                  width: 2),
            ),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButton<String>(
                    iconSize: 25,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    items: [
                      DropdownMenuItem(
                        child: CustomText(
                          alignment: Alignment.center,
                          text: en.value,
                        ),
                        value: en.value,
                      ),
                      DropdownMenuItem(
                        child: CustomText(
                          alignment: Alignment.center,
                          text: ar.value,
                        ),
                        value: ar.value,
                      ),
                    ],
                    onChanged: (String newValue) {
                      settingController.changeLangauge(newValue);
                      Get.updateLocale(Locale(newValue));
                      settingController.saveLangauge(newValue);
                      // Get.offAllNamed(initialRoute, arguments: Binding());
                    }),
              ),
            ),
          )
        ],
      );
    });
  }
}
