import 'package:emoji_alert/resources/constants.dart';
import 'package:emoji_alert/resources/arrays.dart';
import 'package:emoji_alert/resources/sizes.dart';
import 'package:flutter/material.dart';

///Creates the emoji icon with the given [emojiType]
class EmojiIcon extends StatelessWidget {
  EmojiIcon({required this.emojiType, this.emojiSize = defaultEmojiSize});

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
  ///by default it's [defaultEmojiSize]
  final double emojiSize;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(emojis[this.emojiType] ?? "", package: packageName),
      width: this.emojiSize,
    );
  }
}
