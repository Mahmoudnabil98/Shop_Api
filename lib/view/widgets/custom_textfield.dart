import 'package:flutter/material.dart';
import 'package:shop_app/constance.dart';

// ignore: must_be_immutable
class CustomTextFiled extends StatelessWidget {
  Alignment alignment;
  Function validator;
  String text;
  Function onSave;
  TextInputType keyboardType;
  TextEditingController textEditingController;
  CustomTextFiled(
      {Key key,
      this.alignment = Alignment.center,
      this.validator,
      this.text = '',
      this.keyboardType,
      this.onSave,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: TextFormField(
        controller: textEditingController,
        onSaved: onSave,
        keyboardType: keyboardType,
        cursorColor: hexToColor('#667EEA'),
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: hexToColor('#667EEA'),
              ),
            ),
            hoverColor: hexToColor('#667EEA'),
            focusColor: hexToColor('#667EEA'),
            label: Text(text),
            labelStyle: const TextStyle(
              color: Colors.grey,
            )),
        validator: (v) => validator(v),
      ),
    );
  }
}
