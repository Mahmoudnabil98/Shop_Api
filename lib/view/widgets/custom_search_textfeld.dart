import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomSearchTextFiled extends StatelessWidget {
  TextEditingController textEditingController;
  Function onChanged;
  Function onPressed;
  CustomSearchTextFiled(
      {this.textEditingController, this.onChanged, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              spreadRadius: 10,
              offset: const Offset(3, 3),
              color: Get.isDarkMode ? Colors.black45 : Colors.grey.shade100),
        ],
      ),
      height: 52.h,
      margin: EdgeInsets.only(right: 20.w),
      child: Material(
        shadowColor: Colors.grey,
        color:
            Get.isDarkMode ? Colors.black45 : Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        child: TextField(
          controller: textEditingController,
          onChanged: onChanged,
          decoration: InputDecoration(
              label: Text(
                'Search Your Product'.tr,
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.pink[900] : Colors.grey),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Get.isDarkMode ? Colors.black45 : Colors.black45,
              ),
              fillColor: Get.isDarkMode
                  ? Colors.grey.shade500
                  : Theme.of(context).backgroundColor,
              filled: true,
              suffix: IconButton(
                icon: const Icon(Icons.close),
                color: Get.isDarkMode ? Colors.black45 : Colors.white,
                onPressed: onPressed,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Get.isDarkMode ? Colors.black45 : Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Get.isDarkMode ? Colors.black45 : Colors.white),
                borderRadius: BorderRadius.circular(10),
              )),
        ),
      ),
    );
  }
}
