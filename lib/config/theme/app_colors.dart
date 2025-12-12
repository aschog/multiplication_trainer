import 'package:flutter/material.dart';

// Define your palette (Presentation Layer)
class GamePalette {
  static const Color yellow = Color(0xFFFCE38A);
  static const Color blue = Color(0xFF7FBDE8);
  static const Color orange = Color(0xFFFA9C5D);
  static const Color red = Color(0xFFE85D56);
  static const Color textMain = Color(0xFF2F5274);
}

@immutable
class GameThemeColors extends ThemeExtension<GameThemeColors> {
  final Color? numberBtnColor1;
  final Color? numberBtnColor2;
  final Color? numberBtnColor3;
  final Color? deleteBtnColor;
  final Color? textMainColor;

  const GameThemeColors({
    required this.numberBtnColor1,
    required this.numberBtnColor2,
    required this.numberBtnColor3,
    required this.deleteBtnColor,
    required this.textMainColor,
  });

  @override
  GameThemeColors copyWith(
      {Color? numberBtnColor1,
      Color? numberBtnColor2,
      Color? numberBtnColor3,
      Color? textMainColor,
      Color? deleteBtnColor}) {
    return GameThemeColors(
      numberBtnColor1: numberBtnColor1 ?? this.numberBtnColor1,
      numberBtnColor2: numberBtnColor2 ?? this.numberBtnColor2,
      numberBtnColor3: numberBtnColor3 ?? this.numberBtnColor3,
      deleteBtnColor: deleteBtnColor ?? this.deleteBtnColor,
      textMainColor: textMainColor ?? this.textMainColor,
    );
  }

  @override
  ThemeExtension<GameThemeColors> lerp(
      ThemeExtension<GameThemeColors>? other, double t) {
    if (other is! GameThemeColors) return this;
    return GameThemeColors(
      numberBtnColor1: Color.lerp(numberBtnColor1, other.numberBtnColor1, t),
      numberBtnColor2: Color.lerp(numberBtnColor2, other.numberBtnColor2, t),
      numberBtnColor3: Color.lerp(numberBtnColor3, other.numberBtnColor3, t),
      deleteBtnColor: Color.lerp(deleteBtnColor, other.deleteBtnColor, t),
      textMainColor: Color.lerp(textMainColor, other.textMainColor, t),
    );
  }
}
