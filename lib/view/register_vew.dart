import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view/widgets/custom_button.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view/widgets/custom_textfield.dart';
import 'package:shop_app/view/widgets/custom_textfield_password.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/view_model/auth_controller.dart';

class RegisterView extends StatelessWidget {
  AuthController control = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: control.keyRegister,
            child: Container(
              margin: EdgeInsets.only(top: 50.h, left: 20, right: 20),
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
                        text: 'Sign up'.tr,
                        fontSize: 30,
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
                    text: 'Name',
                    onSave: (newValue) {
                      control.name = newValue;
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFiled(
                    text: 'Email'.tr,
                    onSave: (newValue) {
                      control.email = newValue;
                    },
                    validator: (value) => control.validator(value),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFiled(
                    text: 'Phone'.tr,
                    onSave: (newValue) {
                      control.phone = newValue;
                    },
                    keyboardType: TextInputType.number,
                    validator: (value) => control.validator(value),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFeldPassword(
                    text: 'Password'.tr,
                    onSave: (newValue) {
                      control.password = newValue;
                    },
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
                                    if (control.keyRegister.currentState
                                        .validate()) {
                                      control.keyRegister.currentState.save();
                                      control.registerFn(context);
                                    }
                                  },
                            width: 330.w,
                          ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Already have an acoount ?   '.tr,
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      InkWell(
                          onTap: () {
                            Get.offNamed(loginView);
                          },
                          child: CustomText(
                            text: 'Sign in'.tr,
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
