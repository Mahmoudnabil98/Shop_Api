class Favorites {
  bool status;
  String message;
  Data data;

  Favorites({this.status, this.data});

  Favorites.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<FavData> data;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FavData>[];
      json['data'].forEach((v) {
        data.add(FavData.fromJson(v));
      });
    }
  }
}

class FavData {
  int id;
  FavoritesData favoritesData;

  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    favoritesData = json['product'] != null
        ? FavoritesData.fromJson(json['product'])
        : null;
  }
}

class FavoritesData {
  int id;
  num price;
  num oldPrice;
  int discount;
  String image;
  String name;
  String description;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
