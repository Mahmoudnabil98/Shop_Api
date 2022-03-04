class Register {
  bool status;
  String message;
  Data data;

  Register({this.status, this.message, this.data});

  Register.fromJson(Map json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String name;
  String phone;
  String email;
  num id;
  String image;
  String token;

  Data({this.name, this.phone, this.email, this.id, this.image, this.token});

  Data.fromJson(Map json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['id'] = this.id;
    data['image'] = this.image;
    data['token'] = this.token;
    return data;
  }
}
