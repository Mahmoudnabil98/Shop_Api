import 'package:get/get.dart';

class Products {
  bool status;
  ProductsData data;
  Products({this.status, this.data});
  Products.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ProductsData.fromJson(json['data']) : null;
  }
}

class ProductsData {
  List<DataVal> data;

  ProductsData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataVal>[];
      json['data'].forEach((v) {
        data.add(DataVal.fromJson(v));
      });
    }
  }
}

class DataVal {
  int id;
  num price;
  num oldPrice;
  int discount;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  DataVal(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description,
      this.images,
      this.inFavorites,
      this.inCart});

  DataVal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
