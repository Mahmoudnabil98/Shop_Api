class Address {
  bool status;
  String message;
  Data data;

  Address({this.status, this.message, this.data});

  Address.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<AddressData> addressData;
  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      addressData = <AddressData>[];
      json['data'].forEach((v) {
        addressData.add(AddressData.fromJson(v));
      });
    }
  }
}

class AddressData {
  int id;
  String name;
  String city;
  String region;
  String details;
  String notes;
  double latitude;
  double longitude;

  AddressData(
      {this.id,
      this.name,
      this.city,
      this.region,
      this.details,
      this.notes,
      this.latitude,
      this.longitude});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}
