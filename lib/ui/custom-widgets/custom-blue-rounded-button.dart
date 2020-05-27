import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomBlueRoundedButton extends StatelessWidget {
  final onPressed;
  final child;

  CustomBlueRoundedButton({this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: child,
      ),
      color: blueFontLabelColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
    );
  }
}
