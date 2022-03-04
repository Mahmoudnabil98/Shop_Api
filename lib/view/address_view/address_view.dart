import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view/widgets/custom_button.dart';
import 'package:shop_app/view/widgets/custom_text.dart';

class AddressView extends StatelessWidget {
  int val = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Image.asset(
                    'assets/icons/Shape.png',
                    fit: BoxFit.cover,
                    color: Colors.black54,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
              alignment: Alignment.bottomLeft,
              text: 'Address'.tr,
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  maxLines: 3,
                  height: 1.5,
                  text:
                      'Shewrapara, Mirpur, Dhaka-1216 \nHouse no: 938  \nRoad no: 9',
                  color: Colors.black,
                ),
                Radio(
                  activeColor: hexToColor('#667EEA'),
                  value: 1,
                  groupValue: val,
                  onChanged: (value) {
                    val == value;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DottedBorder(
                    strokeCap: StrokeCap.butt,
                    strokeWidth: 1,
                    color: hexToColor('#667EEA'),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 55.h,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed('/CreateAddressView');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/gg.png',
                              color: hexToColor('#667EEA'),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            CustomText(
                              text: 'Add Address',
                              color: hexToColor('#667EEA'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                      text: 'Continue To Payment',
                      width: MediaQuery.of(context).size.width,
                      height: 55.h,
                      fontSize: 20.sp,
                      onPressed: () {}),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
