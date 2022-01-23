import 'package:emoji_alert/resources/sizes.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.buttonSize,
    required this.buttonColor,
    required this.buttonText,
    this.onButtonPressed,
    this.backgroundOpacity = defaultOpacity,
  }) : super(key: key);

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
  ///by default it's set to [defaultOpacity]
  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonSize,
      child: TextButton(
        onPressed: () {
          onButtonPressed?.call();
        },
        child: buttonText,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            buttonColor.withOpacity(backgroundOpacity),
          ),
        ),
      ),
    );
  }
}
