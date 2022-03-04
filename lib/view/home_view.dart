// ignore_for_file: unrelated_type_equality_checks
import 'package:badges/badges.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view/details_product_view.dart';
import 'package:shop_app/view/featured_view.dart';
import 'package:shop_app/view/widgets/badge_widget.dart';
import 'package:shop_app/view/widgets/categories_list.dart';
import 'package:shop_app/view/widgets/custom_button.dart';
import 'package:shop_app/view/widgets/custom_search_textfeld.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view_model/address_controller.dart';
import 'package:shop_app/view_model/cart_controller.dart';
import 'package:shop_app/view_model/favorite_controller.dart';

import 'package:shop_app/view_model/home_controller.dart';
import 'package:shop_app/view_model/network_manager.dart';
import 'widgets/product_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({Key key}) : super(key: key);

  HomeController control = Get.find();
  NetworkManager networkManager = Get.find();
  CartController cartController = Get.find();
  FavoriteController favoriteController = Get.find();
  AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: control.productData,
        header: WaterDropMaterialHeader(
          color: Get.isDarkMode ? Colors.pinkAccent : Colors.blueAccent,
        ),
        controller: control.refreshController,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Image.asset(
                          'assets/icons/Menu Bar.png',
                          fit: BoxFit.cover,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                        onTap: () {
                          Get.toNamed(
                            menuView,
                          );
                          addressController.determinePosition();
                        },
                      ),
                      BadgeWidget(),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  GetX<NetworkManager>(
                      init: NetworkManager(),
                      builder: (controller) {
                        if (controller.connectionType.value == 0) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/wifi.png',
                                  height: 400.h,
                                  width: 200.w,
                                ),
                                CustomButton(
                                  onPressed: () {
                                    control.productData();
                                    control.categoriesData();
                                  },
                                  text: 'No connection'.tr,
                                )
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              GetBuilder<HomeController>(
                                  init: HomeController(),
                                  initState: (state) {
                                    control.isConnection();
                                  },
                                  builder: (_) {
                                    return CustomSearchTextFiled(
                                      onPressed: () {
                                        control.searchClear(context);
                                      },
                                      textEditingController:
                                          control.textEditingController,
                                      onChanged: (serachValue) {
                                        control.productSearch(serachValue);
                                      },
                                    );
                                  }),
                              SizedBox(
                                height: 25.h,
                              ),
                              Obx(() {
                                return control.isloadingProduct.value == true
                                    ? const CircularProgressIndicator()
                                    : CarouselSlider(
                                        items: control.listDiscount.map((e) {
                                          return GestureDetector(
                                              onTap: () {
                                                Get.to(() => DetailsProductView(
                                                      products: e,
                                                    ));
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    child: CachedNetworkImage(
                                                      width: double.infinity,
                                                      imageUrl:
                                                          e.image.toString(),
                                                      fit: BoxFit.contain,
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      placeholder: (context,
                                                              url) =>
                                                          const Center(
                                                              child:
                                                                  const CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Center(
                                                        child: Icon(Icons
                                                            .error_outline),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ));
                                        }).toList(),
                                        options: CarouselOptions(
                                          height: 200.h,
                                          aspectRatio: 16 / 9,
                                          viewportFraction: 0.8,
                                          initialPage: 0,
                                          enableInfiniteScroll: true,
                                          reverse: false,
                                          autoPlay: true,
                                          autoPlayInterval:
                                              const Duration(seconds: 5),
                                          autoPlayAnimationDuration:
                                              const Duration(
                                                  milliseconds: 1000),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enlargeCenterPage: true,
                                          scrollDirection: Axis.horizontal,
                                        ),
                                      );
                              }),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      alignment: Alignment.topLeft,
                                      text: 'Categories'.tr,
                                      color: Colors.black87,
                                      fontSize: 22.sm,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Obx(() => control.isloadingCategory.value == true
                                  ? const CircularProgressIndicator()
                                  : CategoriesList(
                                      list: control.listCategory,
                                    )),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      alignment: Alignment.topLeft,
                                      text: 'Featured'.tr,
                                      color: Colors.black87,
                                      fontSize: 22.sm,
                                    ),
                                    InkWell(
                                        child: CustomText(
                                          alignment: Alignment.topLeft,
                                          text: 'See all'.tr,
                                          color: Colors.grey.shade700,
                                          fontSize: 14.sm,
                                        ),
                                        onTap: () {
                                          Get.to(() =>
                                              FeaturedView(list: control.list));
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() {
                                if (control.isloadingProduct.value == true) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return control.listSearch.isEmpty &&
                                          control.textEditingController.text
                                              .isNotEmpty
                                      ? SvgPicture.asset(
                                          'assets/images/empty.svg')
                                      : Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            Expanded(
                                              child: GridView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 180.w,
                                                    childAspectRatio: 3.w / 2.w,
                                                    mainAxisExtent: 320.h,
                                                    crossAxisSpacing: 20.h,
                                                  ),
                                                  itemCount:
                                                      control.listSearch.isEmpty
                                                          ? control.list.length
                                                          : control.listSearch
                                                              .length,
                                                  itemBuilder:
                                                      (BuildContext ctx,
                                                          index) {
                                                    if (control
                                                        .listSearch.isEmpty) {
                                                      return ProductWidget(
                                                          function: () {
                                                            Get.to(
                                                                DetailsProductView(
                                                              products: control
                                                                  .list[index],
                                                            ));
                                                          },
                                                          image: control
                                                              .list[index].image
                                                              .toString(),
                                                          price: control
                                                              .list[index].price
                                                              .toString(),
                                                          discount: control
                                                              .list[index]
                                                              .oldPrice
                                                              .toString(),
                                                          title: control
                                                              .list[index].name
                                                              .toString(),
                                                          id: control
                                                              .list[index].id,
                                                          inCart: control
                                                              .list[index]
                                                              .inCart);
                                                    } else {
                                                      return ProductWidget(
                                                        function: () {
                                                          Get.to(() =>
                                                              DetailsProductView(
                                                                products: control
                                                                        .listSearch[
                                                                    index],
                                                              ));
                                                        },
                                                        image: control
                                                            .listSearch[index]
                                                            .image
                                                            .toString(),
                                                        price: control
                                                            .listSearch[index]
                                                            .price
                                                            .toString(),
                                                        title: control
                                                            .listSearch[index]
                                                            .name
                                                            .toString(),
                                                        discount: control
                                                            .listSearch[index]
                                                            .oldPrice
                                                            .toString(),
                                                        id: control
                                                            .listSearch[index]
                                                            .id,
                                                        inCart: control
                                                            .listSearch[index]
                                                            .inCart,
                                                      );
                                                    }
                                                  }),
                                            ),
                                          ],
                                        );
                                }
                              })
                            ],
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
