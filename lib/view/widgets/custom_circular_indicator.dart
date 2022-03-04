import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCircularIndicator extends StatelessWidget {
  Color color;
  CustomCircularIndicator({Key key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Get.isDarkMode ? Colors.white : Colors.white,
      ),
    );
  }
}
