import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shop_app/model/address.dart';
import 'package:shop_app/services/address_services.dart';

import '../constance.dart';

class AddressController extends GetxController {
  String name, city, region, details, notes, latitude, longitude;

  var isloading = false.obs;
  var isloadingAddress = false.obs;

  final keyAddr = GlobalKey<FormState>();

  StreamSubscription<Position> streamSubscription;

  var addressList = <AddressData>[].obs;
  var placemarkList = <Placemark>[].obs;
  Address address;
  Position position;
  Placemark placemark;

  @override
  void onReady() {
    getAddress();
    determinePosition();
    super.onReady();
  }

  @override
  void onClose() {
    streamSubscription.cancel();
    super.onClose();
  }

  validator(String value) {
    if (value.isEmpty) {
      return "Please enter the text correctly !";
    } else {
      return;
    }
  }

  Future<String> getToken() async {
    var storage = const FlutterSecureStorage();
    String token = await storage.read(key: 'Token');
    return token;
  }

  Future<void> getAddress() async {
    isloading.value = true;
    try {
      String token = await getToken();
      var value = await AddressServices.getAddress(token);
      if (value != null) {
        addressList.value = value;
      }
    } finally {
      isloading.value = false;
    }
  }

  Future<void> addAddress(BuildContext context) async {
    isloadingAddress.value = true;
    try {
      String token = await getToken();
      address = await AddressServices.addAddress(
              token: token,
              name: name,
              city: city,
              region: region,
              details: details,
              latitude: latitude,
              longitude: longitude,
              notes: notes)
          .catchError((error) {
        showToast(
          '${address.message}',
          context: context,
          backgroundColor:
              Get.isDarkMode ? Colors.pinkAccent : hexToColor('#667EEA'),
        );
      });
      showToast(
        address.message,
        context: context,
        backgroundColor:
            Get.isDarkMode ? Colors.pinkAccent : hexToColor('#667EEA'),
      );
    } finally {
      isloadingAddress.value = false;
    }
  }

  Future<Position> determinePosition({BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      updatePosition(position);
    });
    if (latitude != null || longitude != null) {
      showToast(
        'It has been located'.tr,
        context: context,
        backgroundColor:
            Get.isDarkMode ? Colors.pinkAccent : hexToColor('#667EEA'),
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  void updatePosition(Position position) async {
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    placemarkList.value =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    placemark = placemarkList[0];
  }
}
