import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view/details_product_view.dart';
import 'package:shop_app/view/widgets/badge_widget.dart';
import 'package:shop_app/view/widgets/custom_search_textfeld.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view/widgets/product_widget.dart';
import 'package:shop_app/view_model/home_controller.dart';

// ignore: must_be_immutable
class CategoryDetalsView extends StatelessWidget {
  HomeController homeController = Get.find();
  String name;
  List value;
  CategoryDetalsView({Key key, this.name, this.value}) : super(key: key);
  bool icon = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      onPressed: () {
                        Get.back();
                        homeController.icon.value = false;
                      },
                    ),
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
                          height: 52.h,
                          child: CustomSearchTextFiled(
                            onPressed: () {
                              homeController.switchvalue();
                            },
                          )),
                ],
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                CustomText(
                    alignment: Alignment.bottomLeft,
                    text: name,
                    fontSize: 30,
                    color: Colors.black),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Obx(() {
              return homeController.isloadingCategoryDetals.value == true
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : productView();
            }),
          ],
        ),
      )),
    );
  }

  Widget productView() {
    return Expanded(
      child: GridView.builder(
          primary: false,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180.h,
            childAspectRatio: 3 / 2,
            mainAxisExtent: 330.h,
            crossAxisSpacing: 5.w,
          ),
          itemCount: value.length,
          itemBuilder: (BuildContext ctx, index) {
            return ProductWidget(
                function: () {
                  Get.to(() => DetailsProductView(
                        products: value[index],
                      ));
                },
                image: value[index].image.toString(),
                price: value[index].price.toString(),
                title: value[index].name.toString(),
                discount: value[index].oldPrice.toString(),
                id: value[index].id);
          }),
    );
  }
}
