import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final double buttonSize;
  final Text cancelButtonText;
  final Color cancelButtonColor;
  final Function? onButtonPressed;
  final double backgroundOpacity;

  CancelButton(
      {required this.buttonSize,
      required this.cancelButtonColor,
      required this.cancelButtonText,
      this.onButtonPressed,
      this.backgroundOpacity = 0.2});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.buttonSize,
        child: TextButton(
          onPressed: () {
            this.onButtonPressed?.call();
          },
          child: this.cancelButtonText,
          style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all<Color>(this.cancelButtonColor.withOpacity(this.backgroundOpacity)),
          ),
        ));
  }
}
