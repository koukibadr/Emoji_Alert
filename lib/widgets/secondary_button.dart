import 'package:emoji_alert/sizes.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton(
      {required this.buttonSize,
      required this.buttonColor,
      required this.buttonText,
      this.onButtonPressed,
      this.backgroundOpacity = DEFAULT_OPACITY});

  ///The button size width
  ///
  final double buttonSize;

  ///The confirm button [Text] widget
  ///
  final Text buttonText;

  ///The button background color
  ///
  final Color buttonColor;

  ///Function invoked when pressing the button
  ///
  final Function? onButtonPressed;

  ///the opacity applied to the [buttonColor]
  ///by default it's set to [DEFAULT_OPACITY]
  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.buttonSize,
        child: TextButton(
          onPressed: () {
            this.onButtonPressed?.call();
          },
          child: this.buttonText,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(
                this.buttonColor.withOpacity(this.backgroundOpacity)),
          ),
        ));
  }
}
