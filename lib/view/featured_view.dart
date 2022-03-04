import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/view/details_product_view.dart';
import 'package:shop_app/view/widgets/badge_widget.dart';
import 'package:shop_app/view/widgets/custom_search_textfeld.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view/widgets/product_widget.dart';
import 'package:shop_app/view_model/home_controller.dart';

import '../constance.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class FeaturedView extends StatelessWidget {
  List list;
  HomeController homeController = Get.find();
  bool icon = true;
  FeaturedView({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Get.back();
                          homeController.icon.value = false;
                        },
                      ),
                      homeController.icon.value == false
                          ? Row(
                              children: [
                                InkWell(
                                  child: Image.asset(
                                    'assets/icons/Group 9.png',
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  onTap: () {
                                    homeController.switchvalue();
                                  },
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                BadgeWidget(),
                              ],
                            )
                          : SizedBox(
                              width: 300.w,
                              height: 45.h,
                              child: GetBuilder<HomeController>(builder: (_) {
                                return CustomSearchTextFiled(
                                  onPressed: () {
                                    homeController.searchClear(context);
                                    homeController.icon.value = false;
                                  },
                                  textEditingController:
                                      homeController.textEditingController,
                                  onChanged: (serachValue) {
                                    homeController.productSearch(serachValue);
                                  },
                                );
                              }),
                            ),
                    ]);
              }),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  CustomText(
                      alignment: Alignment.bottomLeft,
                      text: 'Featured'.tr,
                      fontSize: 30.sp,
                      color: Colors.black),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(() {
                if (homeController.isloadingProduct.value == true) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return homeController.listSearch.isEmpty &&
                          homeController.textEditingController.text.isNotEmpty
                      ? SvgPicture.asset('assets/images/empty.svg')
                      : Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 180.h,
                                    childAspectRatio: 3 / 2,
                                    mainAxisExtent: 320.h,
                                    crossAxisSpacing: 15.w,
                                  ),
                                  itemCount: homeController.listSearch.isEmpty
                                      ? list.length
                                      : homeController.listSearch.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    if (homeController.listSearch.isEmpty) {
                                      return ProductWidget(
                                        function: () {
                                          Get.to(DetailsProductView(
                                            products: list[index],
                                          ));
                                        },
                                        image: list[index].image.toString(),
                                        price: list[index].price.toString(),
                                        discount:
                                            list[index].oldPrice.toString(),
                                        title: list[index].name.toString(),
                                        id: list[index].id,
                                      );
                                    } else {
                                      return ProductWidget(
                                        function: () {
                                          Get.to(() => DetailsProductView(
                                                products: homeController
                                                    .listSearch[index],
                                              ));
                                        },
                                        image: homeController
                                            .listSearch[index].image
                                            .toString(),
                                        price: homeController
                                            .listSearch[index].price
                                            .toString(),
                                        title: homeController
                                            .listSearch[index].name
                                            .toString(),
                                        discount: homeController
                                            .listSearch[index].oldPrice
                                            .toString(),
                                        id: homeController.listSearch[index].id,
                                      );
                                    }
                                  }),
                            ),
                          ],
                        );
                }
              })
            ],
          ),
        ),
      )),
    );
  }

  // Widget searchProductView() {
  //   return GridView.builder(
  //       primary: false,
  //       physics: const BouncingScrollPhysics(),
  //       scrollDirection: Axis.vertical,
  //       shrinkWrap: true,
  //       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
  //         maxCrossAxisExtent: 180,
  //         childAspectRatio: 3 / 2,
  //         mainAxisExtent: 270,
  //         crossAxisSpacing: 15,
  //       ),
  //       itemCount: homeController.listSearch.length,
  //       itemBuilder: (BuildContext ctx, index) {
  //         return ProductWidget(
  //           function: () {
  //             Get.to(() => DetailsProductView(
  //                   products: homeController.listSearch[index],
  //                 ));
  //           },
  //           image: homeController.listSearch[index].image.toString(),
  //           price: homeController.listSearch[index].price.toString(),
  //           title: homeController.listSearch[index].name.toString(),
  //           discount: homeController.listSearch[index].oldPrice.toString(),
  //           id: homeController.listSearch[index].id,
  //         );
  //       });
  // }
}
