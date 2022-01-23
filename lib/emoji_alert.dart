import 'dart:async';
import 'package:emoji_alert/widgets/emoji_icon.dart';
import 'package:emoji_alert/resources/arrays.dart';
import 'package:emoji_alert/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'resources/constants.dart';
import 'resources/sizes.dart';
import 'widgets/main_button.dart';

import 'dart:math' as math;

///Creates the main EmojiAlert popup
///[description] is the only required parameter
///by default it creates White popup with [emojiType] set to [EMOJI_TYPE.happy]
///without any button
class EmojiAlert extends StatefulWidget {
  const EmojiAlert({
    Key? key,
    required this.description,
    this.alertTitle,
    this.enableMainButton = false,
    this.enableSecondaryButton = false,
    this.onSecondaryButtonPressed,
    this.onMainButtonPressed,
    this.emojiType = EMOJI_TYPE.happy,
    this.height = defaultPopupHeight,
    this.emojiSize = defaultEmojiSize,
    this.background = Colors.white,
    this.mainButtonColor = Colors.blue,
    this.secondaryButtonColor = Colors.blue,
    this.mainButtonText = const Text(confirmString),
    this.secondaryButtonText = const Text(cancelString),
    this.buttonSize = defaultButtonSize,
    this.cancelButtonColorOpacity = defaultOpacity,
    this.cancelable = true,
    this.cornerRadiusType = CORNER_RADIUS_TYPES.bottomOnly,
    this.width,
    this.animationType = ANIMATION_TYPE.none,
  }) : super(key: key);

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
  ///by default it's [ANIMATION_TYPE.none]
  final ANIMATION_TYPE animationType;

  @override
  _EmojiAlertState createState() => _EmojiAlertState();

  ///Display the alert in a dialog form
  ///[context] the app context to display the alert
  void displayAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (context) {
        return AlertDialog(
          content: this,
          backgroundColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(0),
        );
      },
    );
  }

  ///Display the alert content in a bottom sheet modal
  ///[context] the app context to display the alert
  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: cancelable,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return this;
      },
    );
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

  void _executeAnimation() {
    if (widget.animationType == ANIMATION_TYPE.transition) {
      slideController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
      _offsetAnimation = Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: slideController!,
          curve: Curves.ease,
        ),
      );
      Timer(const Duration(milliseconds: 50), () {
        setState(() {
          slideController!.forward();
        });
      });
    } else if (widget.animationType == ANIMATION_TYPE.fadeIn) {
      opacity = 0;
      Timer(const Duration(milliseconds: 200), () {
        setState(() {
          opacity = 1;
        });
      });
    } else if (widget.animationType == ANIMATION_TYPE.rotation) {
      rotateController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      );
      Timer(const Duration(milliseconds: 120), () {
        rotateController!.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: const Color(0x00000000),
      child: _renderMainWidget(),
    );
  }

  ///render the main widget of the popup
  ///the stack contains the emoji icon with the popup content
  ///
  Widget _renderMainWidget() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: widget.height - (widget.emojiSize * 0.8),
            width: widget.width,
            decoration: BoxDecoration(
              color: widget.background,
              borderRadius: _renderBorderRadius(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: _renderPopupContent(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: _renderAnimatedEmoji(
            EmojiIcon(
              emojiType: widget.emojiType,
              emojiSize: widget.emojiSize,
            ),
          ),
        ),
      ],
    );
  }

  Widget _renderAnimatedEmoji(Widget emoji) {
    switch (widget.animationType) {
      case ANIMATION_TYPE.fadeIn:
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: emoji,
        );
      case ANIMATION_TYPE.transition:
        return SlideTransition(
          position: _offsetAnimation!,
          child: emoji,
        );
      case ANIMATION_TYPE.rotation:
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
  Widget _renderPopupContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            widget.alertTitle != null
                ? Column(
                    children: [
                      widget.alertTitle!,
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Container(),
            widget.description,
          ],
        ),
        _renderAlertButtons() ?? const SizedBox.shrink()
      ],
    );
  }

  ///Render the alert buttons based on the parameters given
  ///
  Widget? _renderAlertButtons() {
    if (widget.enableSecondaryButton || widget.enableMainButton) {
      if (widget.enableSecondaryButton && !widget.enableMainButton) {
        return SecondaryButton(
          buttonSize: widget.buttonSize,
          buttonColor: widget.secondaryButtonColor,
          buttonText: widget.secondaryButtonText,
          onButtonPressed: widget.onSecondaryButtonPressed,
          backgroundOpacity: widget.cancelButtonColorOpacity,
        );
      } else if (!widget.enableSecondaryButton && widget.enableMainButton) {
        return MainButton(
          buttonSize: widget.buttonSize,
          buttonText: widget.mainButtonText,
          buttonColor: widget.mainButtonColor,
          onButtonPressed: widget.onMainButtonPressed,
        );
      } else {
        return Column(
          children: [
            MainButton(
              buttonSize: widget.buttonSize,
              buttonText: widget.mainButtonText,
              buttonColor: widget.mainButtonColor,
              onButtonPressed: widget.onMainButtonPressed,
            ),
            SecondaryButton(
              buttonSize: widget.buttonSize,
              buttonColor: widget.secondaryButtonColor,
              buttonText: widget.secondaryButtonText,
              onButtonPressed: widget.onSecondaryButtonPressed,
              backgroundOpacity: widget.cancelButtonColorOpacity,
            ),
          ],
        );
      }
    }
  }

  ///Calculate the corner radius based on the [widget.cornerRadiusType] parameter
  ///
  BorderRadius? _renderBorderRadius() {
    switch (widget.cornerRadiusType) {
      case CORNER_RADIUS_TYPES.allCorners:
        return const BorderRadius.all(Radius.circular(20));
      case CORNER_RADIUS_TYPES.bottomOnly:
        return const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        );
      case CORNER_RADIUS_TYPES.topOnly:
        return const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        );
      default:
        return null;
    }
  }
}
