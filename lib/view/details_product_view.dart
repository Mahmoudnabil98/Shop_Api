import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/model/favorites.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/view/widgets/badge_widget.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view_model/cart_controller.dart';
import 'package:shop_app/view_model/home_controller.dart';

// ignore: must_be_immutable
class DetailsProductView extends StatefulWidget {
  DataVal products;
  FavData favoritesData;
  DetailsProductView({Key key, this.products, this.favoritesData})
      : super(key: key);

  @override
  State<DetailsProductView> createState() => _DetailsProductViewState();
}

class _DetailsProductViewState extends State<DetailsProductView> {
  bool descTextShowFlag = false;

  HomeController homeController = Get.find();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 55.h,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(color: hexToColor('#E1E1E1')),
                  child: TextButton(
                    onPressed: () {
                      if (widget.products.inCart == true) {
                        showToast(
                          'Product in cart !'.tr,
                          context: context,
                          backgroundColor: Get.isDarkMode
                              ? Colors.pinkAccent
                              : hexToColor('#667EEA'),
                        );
                      } else {
                        cartController.addCartProduct(
                            id: widget.products.id, context: context);
                      }
                    },
                    child: Text('ADD TO CART'.tr,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.pinkAccent
                        : hexToColor('#667EEA'),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'BUY NOW'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back)),
                    BadgeWidget(),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                widget.products.images.length == null
                    ? CachedNetworkImage(
                        placeholder: (context, url) => const Center(
                            child:
                                Expanded(child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Center(
                          child: SizedBox(
                            width: 80.0.w,
                            height: 80.0.h,
                            child: const Icon(Icons.error_outline),
                          ),
                        ),
                        height: 200.h,
                        width: double.infinity,
                        imageUrl: widget.products.image.toString(),
                        fit: BoxFit.scaleDown,
                      )
                    : CarouselSlider(
                        items: widget.products.images.map((e) {
                          return CachedNetworkImage(
                            height: 200.h,
                            width: double.infinity,
                            imageUrl: e.toString(),
                            fit: BoxFit.scaleDown,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error_outline),
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200.h,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                SizedBox(
                  height: 30.h,
                ),
                CustomText(
                    alignment: Alignment.bottomLeft,
                    fontSize: 25.sp,
                    text: widget.products.name.toString(),
                    color: Get.isDarkMode ? Colors.white : Colors.black),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      alignment: Alignment.bottomLeft,
                      fontSize: 20.sp,
                      text: '\$${widget.products.price.toString()}',
                      color: hexToColor('#667EEA'),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        widget.products.oldPrice.toString(),
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: widget.products.discount >= 1
                                  ? Colors.green
                                  : Colors.redAccent,
                              borderRadius: BorderRadius.circular(5)),
                          width: 65.sm,
                          height: 35.sm,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '\$${widget.products.discount}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        CustomText(
                          alignment: Alignment.bottomLeft,
                          fontSize: 15,
                          text: 'Discount'.tr,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(30),
                      child: Obx(() {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: IconButton(
                              onPressed: () {
                                homeController.addfavoriteService(
                                    widget.products.id, context);
                              },
                              icon: homeController.favorites[widget.products.id]
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.grey,
                                    )),
                        );
                      }),
                    )
                  ],
                ),
                SizedBox(height: 5.h),
                const Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    CustomText(
                      fontSize: 16,
                      text: 'Description'.tr,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  child: Column(
                    children: <Widget>[
                      Text(widget.products.description,
                          maxLines: descTextShowFlag ? 25 : 5,
                          textAlign: TextAlign.start),
                      InkWell(
                        onTap: () {
                          setState(() {
                            descTextShowFlag = !descTextShowFlag;
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            descTextShowFlag
                                ? CustomText(
                                    text: "Show Less".tr,
                                    color: Colors.black,
                                    fontSize: 14,
                                  )
                                : Text(
                                    "Show Less".tr,
                                    style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.pinkAccent
                                          : Colors.blueAccent,
                                      fontSize: 15.sp,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
