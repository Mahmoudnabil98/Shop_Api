import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constance.dart';

class CustomButton extends StatelessWidget {
  Function onPressed;
  String text;
  double fontSize;
  double width;
  double height;
  Color color;

  CustomButton({
    this.fontSize = 16,
    @required this.onPressed,
    this.text = '',
    this.height = 49,
    this.width = 245,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(5.r),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode
                  ? Colors.pinkAccent.withOpacity(0.5)
                  : Colors.blueAccent.withOpacity(0.5),
              blurRadius: 10.r,
              spreadRadius: 1.r,

              offset: const Offset(0, 6), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              colors: Get.isDarkMode
                  ? [hexToColor('#FF5858'), hexToColor('#FB5895')]
                  : [hexToColor('#667EEA'), hexToColor('#64B6FF')]),
        ),
        width: width.w,
        height: height.h,
        child: TextButton(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize.sp, color: Colors.white),
          ),
          onPressed: () => onPressed(),
        ),
      ),
    );
  }
}
