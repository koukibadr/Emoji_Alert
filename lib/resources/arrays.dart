import 'constants.dart';

enum EMOJI_TYPE {
  angry,
  confused,
  cool,
  happy,
  joyful,
  laughing,
  sad,
  scared,
  shocked,
  smile,
  wink
}

const Map<EMOJI_TYPE, String> emojis = {
  EMOJI_TYPE.angry: emojiAngry,
  EMOJI_TYPE.confused: emojiConfused,
  EMOJI_TYPE.cool: emojiCool,
  EMOJI_TYPE.joyful: emojiJoyful,
  EMOJI_TYPE.happy: emojiHappy,
  EMOJI_TYPE.laughing: emojiLaughing,
  EMOJI_TYPE.sad: emojiSad,
  EMOJI_TYPE.scared: emojiScared,
  EMOJI_TYPE.shocked: emojiShocked,
  EMOJI_TYPE.smile: emojiSmile,
  EMOJI_TYPE.wink: emojiWink
};

enum CORNER_RADIUS_TYPES {
  bottomOnly,
  topOnly,
  allCorners,
  none,
}

enum ANIMATION_TYPE {
  none,
  fadeIn,
  transition,
  rotation,
}
