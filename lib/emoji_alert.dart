import 'dart:async';

import 'package:emoji_alert/emoji_icon.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/widgets/secondary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'sizes.dart';
import 'widgets/main_button.dart';

import 'dart:math' as math;

///Creates the main EmojiAlert popup
///[description] is the only required parameter
///by default it creates White popup with [emojiType] set to [EMOJI_TYPE.HAPPY]
///without any button
class EmojiAlert extends StatefulWidget {
  EmojiAlert(
      {required this.description,
      this.alertTitle,
      this.enableMainButton = false,
      this.enableSecondaryButton = false,
      this.onSecondaryButtonPressed,
      this.onMainButtonPressed,
      this.emojiType = EMOJI_TYPE.HAPPY,
      this.height = DEFAULT_POPUP_HEIGHT,
      this.emojiSize = DEFAULT_EMOJI_SIZE,
      this.background = Colors.white,
      this.mainButtonColor = Colors.blue,
      this.secondaryButtonColor = Colors.blue,
      this.mainButtonText = const Text(CONFIRM_STRING),
      this.secondaryButtonText = const Text(CANCEL_STRING),
      this.buttonSize = DEFAULT_BUTTON_SIZE,
      this.cancelButtonColorOpacity = DEFAULT_OPACITY,
      this.cancelable = true,
      this.cornerRadiusType = CORNER_RADIUS_TYPES.BOTTOM_ONLY,
      this.width,
      this.animationType = ANIMATION_TYPE.NONE});

  ///Widget used as body in the popup dialog
  ///required attribute
  ///
  final Widget description;

  ///
  ///The title of the popup dialog a Widget type parameter
  ///If it's null the popup will only contain [description]
  final Widget? alertTitle;

  ///used to enable the main button [ElevatedButton]
  ///by default it's set to false so nothing will be rendered
  ///
  final bool enableMainButton;

  ///used to enable the secondary button of type [TextButton]
  ///by default it's false
  final bool enableSecondaryButton;

  ///the function invoked when pressing the main button
  ///By default it's null
  ///
  final Function? onMainButtonPressed;

  ///The function invoked when presseing the secondary button
  final Function? onSecondaryButtonPressed;

  ///The emoji that will be rendered
  ///by default `emojiType = EMOJI_TYPE.HAPPY`
  ///```dart
  ///  {
  /// ANGRY,
  /// CONFUSED,
  /// COOL,
  /// HAPPY,
  /// JOYFUL,
  /// LAUGHING,
  /// SAD,
  /// SCARED,
  /// SHOCKED,
  /// SMILE,
  /// WINK
  /// }
  /// ```
  final EMOJI_TYPE emojiType;

  ///The popup height size
  ///by default it's set to 200
  final double height;

  ///The popup width size, by default it's null
  ///mainly used when displaying the bottom sheet modal
  final double? width;

  ///The emoji size  by default it's 80
  final double emojiSize;

  ///The alert background color used in the popup
  ///by default it's white
  final Color background;

  ///main button background Color
  ///by default it's set to blue
  ///
  final Color mainButtonColor;

  ///The secondary button color, by default it's blue
  ///an opacity value will be added to this color [cancelButtonColorOpacity]
  ///
  final Color secondaryButtonColor;

  /// [Text] widget will be used in the main button widget
  /// by default:
  /// * `const Text("Confirm")`
  final Text mainButtonText;

  ///[Text] widget used in rendering the second button widget
  ///by default:
  ///* `const Text("Cancel")`
  final Text secondaryButtonText;

  ///the width set to buttons both MainButton and SecondaryButton
  ///by default it's 200
  final double buttonSize;

  ///The opacity applied to the secondary button background color
  ///by default it's 0.2
  final double cancelButtonColorOpacity;

  ///define whether the popup is cancelable when pressing outside it.
  ///by default `cancelable = true`
  final bool cancelable;

  /// The popup corners radius
  /// by default `cornerRadiusType = CORNER_RADIUS_TYPES.BOTTOM_ONLY`
  /// possible values:
  /// ```dart
  /// {
  /// BOTTOM_ONLY,
  /// TOP_ONLY,
  /// ALL_CORNERS,
  /// NONE
  /// }
  /// ```
  final CORNER_RADIUS_TYPES cornerRadiusType;

  ///Type of animation that will be applied to the emoji icon
  ///values:
  ///```dart
  ///{
  ///NONE,
  ///FADEIN,
  ///TRANSITION,
  ///ROTATION
  ///}
  ///```
  ///by default it's [ANIMATION_TYPE.NONE]
  final ANIMATION_TYPE animationType;

  @override
  _EmojiAlertState createState() => _EmojiAlertState();

  ///Display the alert in a dialog form
  ///[context] the app context to display the alert
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

  ///Display the alert content in a bottom sheet modal
  ///[context] the app context to display the alert
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

class _EmojiAlertState extends State<EmojiAlert> with TickerProviderStateMixin {
  late double opacity;
  late AnimationController? slideController;
  late Animation<Offset>? _offsetAnimation;
  late AnimationController? rotateController;

  @override
  void initState() {
    super.initState();

    _executeAnimation();
  }

  _executeAnimation() {
    if (this.widget.animationType == ANIMATION_TYPE.TRANSITION) {
      slideController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
      _offsetAnimation = Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: slideController!,
        curve: Curves.ease,
      ));
      Timer(Duration(milliseconds: 50), () {
        setState(() {
          slideController!.forward();
        });
      });
    } else if (this.widget.animationType == ANIMATION_TYPE.FADEIN) {
      this.opacity = 0;
      Timer(Duration(milliseconds: 200), () {
        setState(() {
          this.opacity = 1;
        });
      });
    } else if (this.widget.animationType == ANIMATION_TYPE.ROTATION) {
      rotateController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 300));
      Timer(Duration(milliseconds: 120), () {
        rotateController!.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.widget.height,
      color: Color(0x00000000),
      child: _renderMainWidget(),
    );
  }

  ///render the main widget of the popup
  ///the stack contains the emoji icon with the popup content
  ///
  _renderMainWidget() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: this.widget.height - (this.widget.emojiSize * 0.8),
            width: this.widget.width,
            decoration: BoxDecoration(
                color: this.widget.background,
                borderRadius: _renderBorderRadius()),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: _renderPopupContent(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: _renderAnimatedEmoji(EmojiIcon(
              emojiType: this.widget.emojiType,
              emojiSize: this.widget.emojiSize)),
        ),
      ],
    );
  }

  Widget _renderAnimatedEmoji(Widget emoji) {
    switch (this.widget.animationType) {
      case ANIMATION_TYPE.FADEIN:
        return AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: this.opacity,
            child: emoji);
      case ANIMATION_TYPE.TRANSITION:
        return SlideTransition(
          position: _offsetAnimation!,
          child: emoji,
        );
      case ANIMATION_TYPE.ROTATION:
        return AnimatedBuilder(
          animation: rotateController!,
          builder: (_, child) {
            return Transform.rotate(
              angle: rotateController!.value * 2 * math.pi,
              child: child,
            );
          },
          child: emoji,
        );
      default:
        return emoji;
    }
  }

  ///render the alert content body using [widget.description] and [title] widget
  ///
  _renderPopupContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            this.widget.alertTitle != null
                ? Column(
                    children: [
                      this.widget.alertTitle!,
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Container(),
            this.widget.description,
          ],
        ),
        _renderAlertButtons()
      ],
    );
  }

  ///Render the alert buttons based on the parameters given
  ///
  Widget _renderAlertButtons() {
    if (!this.widget.enableSecondaryButton && !this.widget.enableMainButton) {
      return Container();
    } else {
      if (this.widget.enableSecondaryButton && !this.widget.enableMainButton) {
        return SecondaryButton(
            buttonSize: widget.buttonSize,
            buttonColor: widget.secondaryButtonColor,
            buttonText: widget.secondaryButtonText,
            onButtonPressed: this.widget.onSecondaryButtonPressed,
            backgroundOpacity: this.widget.cancelButtonColorOpacity);
      } else if (!this.widget.enableSecondaryButton &&
          this.widget.enableMainButton) {
        return MainButton(
            buttonSize: widget.buttonSize,
            buttonText: widget.mainButtonText,
            buttonColor: widget.mainButtonColor,
            onButtonPressed: this.widget.onMainButtonPressed);
      } else {
        return Column(
          children: [
            MainButton(
                buttonSize: widget.buttonSize,
                buttonText: widget.mainButtonText,
                buttonColor: widget.mainButtonColor,
                onButtonPressed: this.widget.onMainButtonPressed),
            SecondaryButton(
                buttonSize: widget.buttonSize,
                buttonColor: widget.secondaryButtonColor,
                buttonText: widget.secondaryButtonText,
                onButtonPressed: this.widget.onSecondaryButtonPressed,
                backgroundOpacity: this.widget.cancelButtonColorOpacity),
          ],
        );
      }
    }
  }

  ///Calculate the corner radius based on the [widget.cornerRadiusType] parameter
  ///
  _renderBorderRadius() {
    switch (this.widget.cornerRadiusType) {
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
}
