import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view_model/cart_controller.dart';

class BadgeWidget extends StatelessWidget {
  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Badge(
        position: BadgePosition.topEnd(top: 0, end: 3),
        animationDuration: const Duration(milliseconds: 300),
        animationType: BadgeAnimationType.slide,
        badgeContent: Text(
          '${cartController.cartlist.length}',
          style: const TextStyle(color: Colors.white),
        ),
        child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.toNamed(cartView);
            }),
      );
    });
  }
}
