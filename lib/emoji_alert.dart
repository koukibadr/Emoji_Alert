import 'package:emoji_alert/emoji_type.dart';
import 'package:flutter/material.dart';

class EmojiAlert extends StatelessWidget {
  final String description;
  final String? alertTitle;

  final bool? enableTitle;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;

  final bool? enableConfirmButton;
  final bool? enableCancelButton;

  final Function? onConfirmButtonPressed;
  final Function? onCancelButtonPressed;

  final EMOJI_TYPE emojiType;

  EmojiAlert(
      {required this.description,
      this.alertTitle,
      this.enableTitle,
      this.titleStyle,
      this.messageStyle,
      this.enableConfirmButton,
      this.enableCancelButton,
      this.onCancelButtonPressed,
      this.onConfirmButtonPressed,
      this.emojiType = EMOJI_TYPE.HAPPY});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Color(0x00000000),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage(EMOJIS[this.emojiType] ?? "",
                  package: 'emoji_alert'),
              width: 70,
            ),
          ),
        ],
      ),
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
