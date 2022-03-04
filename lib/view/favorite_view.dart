import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/view/details_product_view.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view/widgets/product_widget.dart';
import 'package:shop_app/view_model/favorite_controller.dart';
import 'package:shop_app/view_model/home_controller.dart';
import 'package:shop_app/view_model/network_manager.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class FavoriteView extends StatelessWidget {
  FavoriteController favoriteController = Get.find();
  NetworkManager networkManager = Get.find();
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  CustomText(
                      alignment: Alignment.bottomLeft,
                      text: 'Favorite'.tr,
                      fontSize: 30,
                      color: Colors.black),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(() {
                return networkManager.connectionType.value == 0
                    ? Expanded(
                        child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/wifi.png',
                              height: 100.h,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomText(
                              text: 'No Network',
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                      ))
                    : favoriteController.isloadingFavorite.value == false
                        ? favoriteController.listFavorite.isEmpty
                            ? SvgPicture.asset(
                                'assets/images/empty.svg',
                                height: 500.h,
                              )
                            : Expanded(
                                child: GridView.builder(
                                    primary: false,
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 180.h,
                                      childAspectRatio: 3 / 2,
                                      mainAxisExtent: 330.h,
                                      crossAxisSpacing: 15.h,
                                    ),
                                    itemCount:
                                        favoriteController.listFavorite.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return GetBuilder<HomeController>(
                                          builder: (controller) {
                                        return controller.favorites[
                                                    favoriteController
                                                        .listFavorite[index]
                                                        .favoritesData
                                                        .id] ==
                                                true
                                            ? Obx(() {
                                                return controller.favorites[
                                                            favoriteController
                                                                .listFavorite[
                                                                    index]
                                                                .favoritesData
                                                                .id] ==
                                                        false
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : ProductWidget(
                                                        function: () {
                                                          Get.toNamed(
                                                              '/DetailsProductView',
                                                              arguments:
                                                                  DetailsProductView(
                                                                favoritesData:
                                                                    favoriteController
                                                                            .listFavorite[
                                                                        index],
                                                              ));
                                                        },
                                                        image: favoriteController
                                                            .listFavorite[index]
                                                            .favoritesData
                                                            .image
                                                            .toString(),
                                                        price: favoriteController
                                                            .listFavorite[index]
                                                            .favoritesData
                                                            .price
                                                            .toString(),
                                                        title: favoriteController
                                                            .listFavorite[index]
                                                            .favoritesData
                                                            .name
                                                            .toString(),
                                                        discount: favoriteController
                                                            .listFavorite[index]
                                                            .favoritesData
                                                            .oldPrice
                                                            .toString(),
                                                        id: favoriteController
                                                            .listFavorite[index]
                                                            .favoritesData
                                                            .id);
                                              })
                                            : favoriteController
                                                    .listFavorite.value.isEmpty
                                                ? Center(
                                                    child: SvgPicture.asset(
                                                    'assets/images/empty.svg',
                                                  ))
                                                : const SizedBox();
                                      });
                                    }),
                              )
                        : const Expanded(
                            child: Center(child: CircularProgressIndicator()));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
