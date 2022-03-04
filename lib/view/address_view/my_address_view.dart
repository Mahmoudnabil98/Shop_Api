import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view_model/address_controller.dart';

// ignore: must_be_immutable
class MyAddressView extends StatelessWidget {
  Rx<bool> val = false.obs;

  AddressController addressController = Get.find();

  MyAddressView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
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
                    icon: const Icon(Icons.arrow_back)),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                CustomText(
                  alignment: Alignment.bottomLeft,
                  text: 'Address'.tr,
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Obx(() {
              return addressController.isloading.value == true
                  ? const CircularProgressIndicator()
                  : addressController.addressList.isEmpty
                      ? SvgPicture.asset(
                          'assets/images/empty.svg',
                          height: 200.h,
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: addressController.addressList
                                .map(
                                  (e) => Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 20.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            height: 1.5,
                                            text:
                                                '${e.name}, ${e.city}, ${e.region} / ${e.details} / ${e.notes} / ${e.latitude} - ${e.longitude} ',
                                            color: Colors.black,
                                            softWrap: true,
                                            maxLines: 3,
                                            textOverflow: TextOverflow.fade,
                                          ),
                                        ),
                                        Radio(
                                          activeColor: Get.isDarkMode
                                              ? Colors.pinkAccent
                                              : hexToColor('#667EEA'),
                                          value: 1,
                                          groupValue: 2,
                                          onChanged: (value) {
                                            val == value;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        );
            }),
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: DottedBorder(
              strokeCap: StrokeCap.butt,
              strokeWidth: 1,
              color: Get.isDarkMode ? Colors.pinkAccent : hexToColor('#667EEA'),
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
                        color: Get.isDarkMode
                            ? Colors.pinkAccent
                            : hexToColor('#667EEA'),
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomText(
                        text: 'Add Address'.tr,
                        color: Get.isDarkMode
                            ? Colors.pinkAccent
                            : hexToColor('#667EEA'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
