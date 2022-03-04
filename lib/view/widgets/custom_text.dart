import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  String text;
  TextAlign textAlign;
  Color color;
  double fontSize;
  FontWeight fontWeight;
  Alignment alignment;
  TextOverflow textOverflow;
  int maxLines;
  double height;
  bool softWrap = false;

  CustomText({
    this.text = " ",
    this.alignment = Alignment.center,
    this.color = Colors.blueAccent,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
    this.maxLines,
    this.height,
    this.textOverflow,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        softWrap: softWrap,
        maxLines: maxLines,
        textAlign: textAlign,
        style: TextStyle(
          overflow: textOverflow,
          height: height,
          color: Theme.of(context).primaryColor,
          fontFamily: Theme.of(context).textTheme.toString(),
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
