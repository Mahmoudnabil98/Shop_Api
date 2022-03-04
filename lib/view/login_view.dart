// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/view/widgets/custom_button.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view/widgets/custom_textfield.dart';
import 'package:shop_app/view/widgets/custom_textfield_password.dart';
import 'package:shop_app/view_model/auth_controller.dart';

import '../constance.dart';

// ignore: use_key_in_widget_constructors
class LoginView extends StatelessWidget {
  AuthController control = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: control.keyLogin,
            child: Container(
              margin: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: IconButton(
                            onPressed: () {
                              Get.offNamed(switchView);
                            },
                            icon: const Icon(Icons.arrow_back)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      CustomText(
                        alignment: Alignment.bottomLeft,
                        text: 'Login'.tr,
                        fontSize: 30.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFiled(
                    validator: (value) => control.validator(value),
                    text: 'Email'.tr,
                    onSave: (newValue) {
                      control.email = newValue;
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFeldPassword(
                    onSave: (newValue) {
                      control.password = newValue;
                    },
                    text: 'Password'.tr,
                    validator: (value) => control.validator(value),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Obx(
                    () => control.isLoading.value == true
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: 'Log in'.tr,
                            onPressed: control.isLoading.value == true
                                ? () {}
                                : () {
                                    if (control.keyLogin.currentState
                                        .validate()) {
                                      control.keyLogin.currentState.save();
                                      control.login(context);
                                    }
                                  },
                            width: 330,
                          ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Don\'t have an acoount ?   '.tr,
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(registerView);
                          },
                          child: CustomText(
                            text: 'Sign Up'.tr,
                            fontSize: 13,
                            color: Colors.black87,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
