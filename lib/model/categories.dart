class CategoriesOne {
  String name;
  String image;
  CategoriesOne({this.image, this.name});
}

class Categories {
  bool status;
  Data data;
  Categories({this.status, this.data});

  Categories.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int currentPage;
  List<DataVal> data;
  Data({
    this.currentPage,
    this.data,
  });

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataVal>[];
      json['data'].forEach((v) {
        data.add(DataVal.fromJson(v));
      });
    }
  }
}

class DataVal {
  num id;
  String name;
  String image;

  DataVal({this.id, this.name, this.image});

  DataVal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
