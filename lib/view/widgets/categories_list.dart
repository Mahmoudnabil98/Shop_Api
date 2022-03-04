import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/view/categorydetals_view.dart';
import 'package:shop_app/view_model/home_controller.dart';

// ignore: must_be_immutable
class CategoriesList extends StatelessWidget {
  List list;
  Function onTap;
  HomeController homeController = Get.find();
  CategoriesList({Key key, this.list, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 65.h,
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) => GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            width: 140.w,
            height: 30.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    colorFilter: const ColorFilter.mode(
                        Colors.black38, BlendMode.darken),
                    image: CachedNetworkImageProvider(
                        list[index].image.toString()))),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                list[index].name.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onTap: () {
            homeController.categoriesDetals(id: list[index].id);

            Get.to(
              () => CategoryDetalsView(
                name: list[index].name,
                value: homeController.listCategoryDetals,
              ),
            );
          },
        ),
      ),
    );
  }
}
