import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view_model/cart_controller.dart';
import 'package:shop_app/view_model/favorite_controller.dart';
import 'package:shop_app/view_model/home_controller.dart';
import 'package:transparent_image/transparent_image.dart';

// ignore: must_be_immutable
class ProductWidget extends StatelessWidget {
  FavoriteController favoriteController = Get.find();
  HomeController homeController = Get.find();
  CartController cartController = Get.find();
  String title, image, price, discount, inFavorites;
  bool inCart;
  num id;
  Function function;
  ProductWidget({
    Key key,
    this.title,
    this.image,
    this.price,
    this.function,
    this.discount,
    this.inCart,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
          onTap: () => function(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    height: 200.h,
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                        image: image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Obx(() {
                    return IconButton(
                        onPressed: () {
                          homeController.addfavoriteService(id, context);
                        },
                        icon: homeController.favorites[id] == true
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                              )
                            : const Icon(
                                Icons.favorite,
                                color: Colors.grey,
                              ));
                  }),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FittedBox(
                    child: Text(
                      '\$$price',
                      style: TextStyle(
                        fontSize: 16.sm,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      '\$$discount',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12.sm),
                    ),
                  ),
                  FittedBox(
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart_rounded,
                        color: Get.isDarkMode
                            ? Colors.pinkAccent
                            : Colors.blueAccent,
                      ),
                      onPressed: () {
                        cartController.addCartProduct(id: id, context: context);
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                child: CustomText(
                  alignment: Alignment.bottomLeft,
                  fontSize: 16.sm,
                  text: title,
                  color: Colors.black,
                  maxLines: 2,
                ),
              ),
            ],
          )),
    );
  }
}
