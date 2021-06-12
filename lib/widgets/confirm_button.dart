import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton(
      {Key? key,
      required this.buttonSize,
      required this.confirmButtonText,
      required this.confirmButtonColor,
      required this.onButtonPressed})
      : super(key: key);

  final double buttonSize;
  final Text? confirmButtonText;
  final Color confirmButtonColor;
  final Function? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.buttonSize,
      child: ElevatedButton(
        onPressed: () {
          this.onButtonPressed?.call();
        },
        child: this.confirmButtonText,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(this.confirmButtonColor),
        ),
      ),
    );
  }
}
