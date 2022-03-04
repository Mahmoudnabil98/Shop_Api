import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/view/widgets/custom_button.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view/widgets/custom_textfield.dart';
import 'package:shop_app/view/widgets/custom_textfield_password.dart';
import 'package:shop_app/view_model/auth_controller.dart';
import 'package:shop_app/view_model/profile_controller.dart';

class ProfileEditView extends StatelessWidget {
  ProfileController profileController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Form(
        key: profileController.keyPro,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                CustomText(
                  alignment: Alignment.bottomLeft,
                  text: 'Edit Profile'.tr,
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            SizedBox(height: 30.h),
            CustomTextFiled(
              text: 'Name'.tr,
              keyboardType: TextInputType.name,
              onSave: (value) {
                profileController.name = value;
              },
              validator: (value) => profileController.validator(value),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email".tr,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: CustomText(
                    alignment: Alignment.centerLeft,
                    text: authController.userModel.data.email.toString(),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black54,
              thickness: 1,
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextFiled(
              text: 'Phone'.tr,
              keyboardType: TextInputType.phone,
              onSave: (value) {
                profileController.phone = value;
              },
              validator: (value) => profileController.validator(value),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFeldPassword(
              text: 'Password'.tr,
              validator: (value) => profileController.validator(value),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                text: 'Edit Profile'.tr,
                fontSize: 20,
                onPressed: () {
                  if (profileController.keyPro.currentState.validate()) {
                    profileController.keyPro.currentState.save();
                    profileController.edtProfileContol(context);
                  }
                },
                width: 326.w,
              ),
            ))
          ]),
        ),
      )),
    );
  }
}
