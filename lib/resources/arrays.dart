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
  EMOJI_TYPE.angry: EMOJI_ANGRY,
  EMOJI_TYPE.confused: EMOJI_CONFUSED,
  EMOJI_TYPE.cool: EMOJI_COOL,
  EMOJI_TYPE.joyful: EMOJI_JOYFUL,
  EMOJI_TYPE.happy: EMOJI_HAPPY,
  EMOJI_TYPE.laughing: EMOJI_LAUGHING,
  EMOJI_TYPE.sad: EMOJI_SAD,
  EMOJI_TYPE.scared: EMOJI_SCARED,
  EMOJI_TYPE.shocked: EMOJI_SHOCKED,
  EMOJI_TYPE.smile: EMOJI_SMILE,
  EMOJI_TYPE.wink: EMOJI_WINK
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
