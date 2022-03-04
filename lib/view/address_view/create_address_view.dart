import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view/widgets/custom_button.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view/widgets/custom_textfield.dart';
import 'package:shop_app/view_model/address_controller.dart';

class CreateAddressView extends StatelessWidget {
  AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    //log("${addressController.placemarkList.value[0]}");
    //log("place ${addressController.position.latitude}");

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Form(
        key: addressController.keyAddr,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            ),
            Row(
              children: [
                CustomText(
                  alignment: Alignment.bottomLeft,
                  text: 'Create Address'.tr,
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  CustomTextFiled(
                    text: 'Name'.tr,
                    keyboardType: TextInputType.name,
                    validator: (value) => addressController.validator(value),
                    onSave: (String newValue) {
                      addressController.name = newValue;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFiled(
                    onSave: (String newValue) {
                      addressController.city = newValue;
                    },
                    text: 'City'.tr,
                    keyboardType: TextInputType.streetAddress,
                    validator: (value) => addressController.validator(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFiled(
                    onSave: (String newValue) {
                      addressController.region = newValue;
                    },
                    text: 'region'.tr,
                    keyboardType: TextInputType.streetAddress,
                    validator: (value) => addressController.validator(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFiled(
                    onSave: (String newValue) {
                      addressController.details = newValue;
                    },
                    text: 'details'.tr,
                    keyboardType: TextInputType.text,
                    validator: (value) => addressController.validator(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFiled(
                    text: 'Notes'.tr,
                    keyboardType: TextInputType.phone,
                    validator: (value) => addressController.validator(value),
                    onSave: (String newValue) {
                      addressController.notes = newValue;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Material(
                    color: Get.isDarkMode
                        ? Colors.pinkAccent
                        : hexToColor('#64B6FF'),
                    borderRadius: BorderRadius.circular(15),
                    elevation: 5,
                    child: Container(
                      height: 50.h,
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextButton(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.white,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              CustomText(
                                text: "Click to Locate".tr,
                              )
                            ],
                          ),
                          onPressed: () {
                            addressController.determinePosition(
                                context: context);
                          }),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        text: 'Add Address'.tr,
        fontSize: 20,
        onPressed: () {
          if (addressController.keyAddr.currentState.validate()) {
            addressController.keyAddr.currentState.save();
            addressController.addAddress(context);
            addressController.getAddress();
            if (addressController.latitude != null) {
              Get.toNamed(addressView);
            }
          }
        },
        width: 326.w,
      ),
    );
  }
}
