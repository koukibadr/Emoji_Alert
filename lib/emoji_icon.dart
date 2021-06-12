import 'package:emoji_alert/constants.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:flutter/material.dart';

class EmojiIcon extends StatelessWidget {
  final EMOJI_TYPE emojiType;
  final double emojiSize;

  EmojiIcon({required this.emojiType, this.emojiSize = 70});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(EMOJIS[this.emojiType] ?? "", package: PACKAGE_NAME),
      width: this.emojiSize,
    );
  }
}
