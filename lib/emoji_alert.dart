import 'package:emoji_alert/emoji_icon.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/widgets/cancel_button.dart';
import 'package:flutter/cupertino.dart';
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
  final double? width;
  final double emojiSize;

  final Color background;

  final Color confirmButtonColor;
  final Color cancelButtonColor;
  final bool confirmButtonEnabled;
  final bool cancelButtonEnabled;
  final Text confirmButtonText;
  final Text cancelButtonText;

  final double buttonSize;

  final double cancelButtonColorOpacity;

  final bool cancelable;

  final CORNER_RADIUS_TYPES cornerRadiusType;

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
      this.background = Colors.white,
      this.confirmButtonColor = Colors.blue,
      this.cancelButtonColor = Colors.blue,
      this.confirmButtonEnabled = true,
      this.cancelButtonEnabled = false,
      this.confirmButtonText = const Text("Confirm"),
      this.cancelButtonText = const Text("Cancel"),
      this.buttonSize = 200,
      this.cancelButtonColorOpacity = 0.2,
      this.cancelable = true,
      this.cornerRadiusType = CORNER_RADIUS_TYPES.BOTTOM_ONLY,
      this.width});

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
            width: this.width,
            decoration: BoxDecoration(
                color: this.background, borderRadius: _renderBorderRadius()),
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
    if (!this.cancelButtonEnabled && !this.confirmButtonEnabled) {
      return Container();
    } else {
      if (this.cancelButtonEnabled && !this.confirmButtonEnabled) {
        return CancelButton(
            buttonSize: buttonSize,
            cancelButtonColor: cancelButtonColor,
            cancelButtonText: cancelButtonText,
            onButtonPressed: this.onCancelButtonPressed,
            backgroundOpacity: this.cancelButtonColorOpacity);
      } else if (!this.cancelButtonEnabled && this.confirmButtonEnabled) {
        return ConfirmButton(
            buttonSize: buttonSize,
            confirmButtonText: confirmButtonText,
            confirmButtonColor: confirmButtonColor,
            onButtonPressed: this.onConfirmButtonPressed);
      } else {
        return Column(
          children: [
            ConfirmButton(
                buttonSize: buttonSize,
                confirmButtonText: confirmButtonText,
                confirmButtonColor: confirmButtonColor,
                onButtonPressed: this.onConfirmButtonPressed),
            CancelButton(
                buttonSize: buttonSize,
                cancelButtonColor: cancelButtonColor,
                cancelButtonText: cancelButtonText,
                onButtonPressed: this.onCancelButtonPressed,
                backgroundOpacity: this.cancelButtonColorOpacity),
          ],
        );
      }
    }
  }

  _renderBorderRadius() {
    switch (this.cornerRadiusType) {
      case CORNER_RADIUS_TYPES.ALL_CORNERS:
        return BorderRadius.all(Radius.circular(20));
      case CORNER_RADIUS_TYPES.BOTTOM_ONLY:
        return BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        );
      case CORNER_RADIUS_TYPES.TOP_ONLY:
        return BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        );
      default:
        return null;
    }
  }

  displayAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: this.cancelable,
        builder: (context) {
          return AlertDialog(
            content: this,
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(0),
          );
        });
  }

  displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isDismissible: this.cancelable,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return this;
        });
  }
}
