import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/text-styles.dart';

class CustomRoundedTextField extends StatelessWidget {
  final hint;
  final label;
  final onChange;
  final isPassword;
  final bottomPadding;
  final textCapitalization;
  final inputType;
  final controller;
  final iconData;

  CustomRoundedTextField(
      {this.hint = '',
      this.iconData,
      this.controller,
      this.inputType = TextInputType.text,
      this.label,
      this.onChange,
      this.isPassword = false,
      this.bottomPadding = 16,
      this.textCapitalization = TextCapitalization.none});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        textCapitalization: textCapitalization,
        obscureText: isPassword,
        style:
            TextStyle(fontSize: 15, color: mainThemeColor, fontFamily: 'Arial'),
        decoration: InputDecoration(
//          prefix: Icon(
//            iconData,
//            color: mainThemeColor,
//          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: mainThemeColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: mainThemeColor,
            ),
          ),
          labelText: label,
          labelStyle: textFieldLabelTS,
          hintText: hint,
          hintStyle: TextStyle(
              fontSize: 14, color: Color(0x5544C7D9), fontFamily: 'Arial'),
        ),
        onChanged: onChange,
      ),
    );
  }
}
