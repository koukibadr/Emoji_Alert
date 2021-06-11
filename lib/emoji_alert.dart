import 'package:emoji_alert/emoji_icon.dart';
import 'package:emoji_alert/emoji_type.dart';
import 'package:emoji_alert/widgets/cancel_button.dart';
import 'package:flutter/material.dart';

import 'widgets/confirm_button.dart';

class EmojiAlert extends StatelessWidget {
  final Widget description;
  final Widget? alertTitle;

  final bool? enableConfirmButton;
  final bool? enableCancelButton;

  final Function? onConfirmButtonPressed;
  final Function? onCancelButtonPressed;

  final EMOJI_TYPE emojiType;

  final double height;
  final double emojiSize;

  final bool roundCorners;

  final Color background;

  final Color confirmButtonColor;
  final Color cancelButtonColor;
  final bool confirmButtonEnabled;
  final bool cancelButtonEnabled;
  final Text? confirmButtonText;
  final Text? cancelButtonText;

  final double buttonSize;

  EmojiAlert(
      {required this.description,
      this.alertTitle,
      this.enableConfirmButton,
      this.enableCancelButton,
      this.onCancelButtonPressed,
      this.onConfirmButtonPressed,
      this.emojiType = EMOJI_TYPE.HAPPY,
      this.height = 200,
      this.emojiSize = 80,
      this.roundCorners = true,
      this.background = Colors.white,
      this.confirmButtonColor = Colors.blue,
      this.cancelButtonColor = Colors.blue,
      this.confirmButtonEnabled = true,
      this.cancelButtonEnabled = false,
      this.confirmButtonText = const Text("Confirm"),
      this.cancelButtonText,
      this.buttonSize = 200});

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
                color: this.background,
                borderRadius: this.roundCorners
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                    : null),
            child: Padding(
              padding: EdgeInsets.all(30),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            this.alertTitle != null
                ? Column(
                    children: [
                      this.alertTitle!,
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Container(),
            this.description,
          ],
        ),
        _renderButtons()
      ],
    );
  }

  Widget _renderButtons() {
    if (!this.cancelButtonEnabled && this.confirmButtonEnabled) {
      return Container();
    } else {
      if (this.cancelButtonEnabled && !this.confirmButtonEnabled) {
        return CancelButton(
            buttonSize: buttonSize,
            cancelButtonColor: cancelButtonColor,
            cancelButtonText: cancelButtonText!);
      } else if (!this.cancelButtonEnabled && this.confirmButtonEnabled) {
        return ConfirmButton(
            buttonSize: buttonSize,
            confirmButtonText: confirmButtonText,
            confirmButtonColor: confirmButtonColor);
      } else {
        return Column(
          children: [
            ConfirmButton(
                buttonSize: buttonSize,
                confirmButtonText: confirmButtonText,
                confirmButtonColor: confirmButtonColor),
            CancelButton(
                buttonSize: buttonSize,
                cancelButtonColor: cancelButtonColor,
                cancelButtonText: cancelButtonText!),
          ],
        );
      }
    }
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
