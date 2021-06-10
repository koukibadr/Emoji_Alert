import 'package:emoji_alert/emoji_icon.dart';
import 'package:emoji_alert/emoji_type.dart';
import 'package:flutter/material.dart';

class EmojiAlert extends StatelessWidget {
  final String description;
  final String? alertTitle;

  final bool enableTitle;
  final TextStyle titleStyle;
  final TextStyle descriptionTextStyle;

  final bool? enableConfirmButton;
  final bool? enableCancelButton;

  final Function? onConfirmButtonPressed;
  final Function? onCancelButtonPressed;

  final EMOJI_TYPE emojiType;

  final double height;
  final double emojiSize;

  EmojiAlert(
      {required this.description,
      this.alertTitle,
      this.titleStyle = const TextStyle(color: Colors.black),
      this.descriptionTextStyle = const TextStyle(color: Colors.black),
      this.enableConfirmButton,
      this.enableCancelButton,
      this.onCancelButtonPressed,
      this.onConfirmButtonPressed,
      this.enableTitle = false,
      this.emojiType = EMOJI_TYPE.HAPPY,
      this.height = 200,
      this.emojiSize = 80});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      color: Color(0x00000000),
      child: _renderSimpleAlert(),
    );
  }

  _renderSimpleAlert() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: this.height - (this.emojiSize * 0.8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Padding(
              padding: EdgeInsets.only(
                top: 30,
                left: 40,
                right: 40,
              ),
              child: _renderSimpleAlertBody(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child:
              EmojiIcon(emojiType: this.emojiType, emojiSize: this.emojiSize),
        ),
      ],
    );
  }

  _renderSimpleAlertBody() {
    return Column(
      children: [
        this.enableTitle
            ? Column(
                children: [
                  Text(this.alertTitle ?? "", style: this.titleStyle),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )
            : Container(),
        Text(this.description, style: this.descriptionTextStyle)
      ],
    );
  }

  show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: this,
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(0),
          );
        });
  }
}
