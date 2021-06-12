import 'package:flutter/material.dart';


///Creates [ElevatedButton] widget with a given width size
///
class MainButton extends StatelessWidget {
  
  MainButton(
      {required this.buttonSize,
      required this.buttonText,
      required this.buttonColor,
      this.onButtonPressed});

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
    return Container(
      width: this.buttonSize,
      child: ElevatedButton(
        onPressed: () {
          this.onButtonPressed?.call();
        },
        child: this.buttonText,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(this.buttonColor),
        ),
      ),
    );
  }
}
