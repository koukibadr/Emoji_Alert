import 'package:emoji_alert/constants.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/sizes.dart';
import 'package:flutter/material.dart';

///Creates the emoji icon with the given [emojiType]
class EmojiIcon extends StatelessWidget {
  EmojiIcon({required this.emojiType, this.emojiSize = DEFAULT_EMOJI_SIZE});

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

  ///The emoji size width
  ///by default it's [DEFAULT_EMOJI_SIZE]
  final double emojiSize;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(EMOJIS[this.emojiType] ?? "", package: PACKAGE_NAME),
      width: this.emojiSize,
    );
  }
}
