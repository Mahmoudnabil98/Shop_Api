import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view/widgets/custom_button.dart';
import 'package:shop_app/view/widgets/custom_circular_indicator.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view_model/cart_controller.dart';
import 'package:shop_app/view_model/network_manager.dart';
import '../../constance.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class CartView extends StatelessWidget {
  CartController cartController = Get.find();
  NetworkManager networkManager = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: const Icon(Icons.arrow_back),
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        alignment: Alignment.bottomLeft,
                        text: 'Cart'.tr,
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                      Obx(() {
                        return cartController.cartlist.value.isEmpty
                            ? Container()
                            : Row(
                                children: [
                                  CustomText(
                                    text: 'Total'.tr,
                                    fontSize: 25,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Container(
                                    child: cartController.isLoadingCart.value ==
                                            true
                                        ? CustomCircularIndicator()
                                        : Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 30.h,
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Get.isDarkMode
                                                        ? Colors.pinkAccent
                                                        : hexToColor(
                                                            '#64B6FF')),
                                                child: Text(
                                                  '\$${cartController.data.value.total.toString()}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                  )
                                ],
                              );
                      }),
                    ],
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
                            ),
                          )
                        : cartController.cartlist.value.isEmpty
                            ? SvgPicture.asset(
                                'assets/images/empty.svg',
                                height: 500.h,
                              )
                            : GetBuilder<CartController>(builder: (controller) {
                                return Expanded(
                                  child: ListView.separated(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 30.h),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: controller.cartlist.length,
                                    itemBuilder: (context, index) {
                                      return Obx(() {
                                        return Material(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          elevation: 5,
                                          child: Container(
                                            height: 150.h,
                                            width: 326.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Get.isDarkMode
                                                    ? Colors.pinkAccent.shade700
                                                    : Colors.grey.shade100,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade400,
                                                    offset:
                                                        const Offset(0.1, 0.5))
                                              ],
                                              color: Get.isDarkMode
                                                  ? const Color(0xFF212121)
                                                  : hexToColor('#FFFFFF'),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 15.h,
                                              ),
                                              child: SizedBox(
                                                width: 200.w,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  15),
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: controller
                                                                  .cartlist[
                                                                      index]
                                                                  .product
                                                                  .image
                                                                  .toString(),
                                                              fit: BoxFit
                                                                  .contain,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const Center(
                                                                      child:
                                                                          CircularProgressIndicator()),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Center(
                                                                child: Icon(Icons
                                                                    .error_outline),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            child: CustomText(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              text:
                                                                  "${controller.cartlist[index].product.name.toString()}",
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                              textOverflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              softWrap: true,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                          Text(
                                                            '\$${controller.cartlist[index].product.price.toString()}',
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .blueAccent),
                                                          ),
                                                          Container(
                                                              height: 42.h,
                                                              width: 120,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .pinkAccent
                                                                      : hexToColor(
                                                                          '#F6F6F6')),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        cartController
                                                                            .quantityMinus(cartController.cartlist[index]);
                                                                        if (cartController.cartlist[index].quantity <
                                                                            1) {
                                                                          controller.addCartProduct(
                                                                              id: controller.cartlist[index].product.id,
                                                                              context: context);

                                                                          controller
                                                                              .deleteItem(index);
                                                                        }
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .remove,
                                                                      )),
                                                                  CustomText(
                                                                    text: controller
                                                                        .cartlist[
                                                                            index]
                                                                        .quantity
                                                                        .toString(),
                                                                  ),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        cartController
                                                                            .quantityAdd(cartController.cartlist[index]);
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .add,
                                                                      )),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w),
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: IconButton(
                                                          icon: Image.asset(
                                                              'assets/icons/Cencel Icon.png'),
                                                          onPressed: () {
                                                            controller.addCartProduct(
                                                                id: controller
                                                                    .cartlist[
                                                                        index]
                                                                    .product
                                                                    .id,
                                                                context:
                                                                    context);

                                                            controller
                                                                .deleteItem(
                                                                    index);
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: 5.h,
                                      );
                                    },
                                  ),
                                );
                              });
                  }),
                ],
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          height: 110.h,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            CustomButton(
              onPressed: () {},
              width: 326.w,
              height: 55.h,
              fontSize: 20,
              text: 'Continue',
            ),
          ])),
    );
  }
}
