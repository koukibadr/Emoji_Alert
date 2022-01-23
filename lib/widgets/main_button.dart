import 'package:flutter/material.dart';

///Creates [ElevatedButton] widget with a given width size
///
class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.buttonSize,
    required this.buttonText,
    required this.buttonColor,
    this.onButtonPressed,
  }) : super(key: key);

  ///The button size width
  ///
  final double buttonSize;

  ///The confirm button [Text] widget
  ///
  final Text? buttonText;

  ///The button background color
  ///
  final Color buttonColor;

  ///Function invoked when pressing the button
  ///
  final Function? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonSize,
      child: ElevatedButton(
        onPressed: () {
          onButtonPressed?.call();
        },
        child: buttonText,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        ),
      ),
    );
  }
}
