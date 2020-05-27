import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomBlueOutlinedButton extends StatelessWidget {
  final onPressed;
  final child;

  CustomBlueOutlinedButton({this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      onPressed: onPressed,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14), child: child),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: mainThemeColor),
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
    );
  }
}
