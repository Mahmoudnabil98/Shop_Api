import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/view_model/auth_controller.dart';

class CustomTextFeldPassword extends StatelessWidget {
  AuthController control = Get.find();
  String text;
  Function validator;
  Function onSave;
  CustomTextFeldPassword(
      {Key key,
      @required this.text = '',
      @required this.validator,
      this.onSave})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => TextFormField(
        validator: (v) => validator(v),
        onSaved: onSave,
        obscureText: controller.isObscure.value,
        decoration: InputDecoration(
            label: Text(text),
            suffixIcon: IconButton(
                icon: Icon(
                  controller.isObscure.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  controller.obscure();
                })),
      ),
    );
  }
}
