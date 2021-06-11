import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final double buttonSize;
  final Text cancelButtonText;
  final Color cancelButtonColor;

  CancelButton(
      {required this.buttonSize,
      required this.cancelButtonColor,
      required this.cancelButtonText});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.buttonSize,
        child: TextButton(
          onPressed: () {},
          child: this.cancelButtonText,
          style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all<Color>(this.cancelButtonColor),
          ),
        ));
  }
}
