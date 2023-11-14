import 'package:flutter/material.dart';

class ColorThemeExt extends ThemeExtension<ColorThemeExt> {
  final Color white;
  final Color black;
  final Color textBlack;
  final Color blue;
  final Color purple;
  final Color red;
  final Color yellow;

  ColorThemeExt({
    required this.blue,
    required this.black,
    required this.textBlack,
    required this.white,
    required this.purple,
    required this.red,
    required this.yellow,
  });
  @override
  ThemeExtension<ColorThemeExt> copyWith({
    Color? white,
    Color? blue,
    Color? black,
    Color? textBlack,
    Color? purple,
    Color? red,
    Color? yellow,
  }) {
    return ColorThemeExt(
      black: black ?? this.black,
      textBlack: textBlack ?? this.textBlack,
      white: white ?? this.white,
      purple: purple ?? this.purple,
      red: red ?? this.red,
      blue: blue ?? this.blue,
      yellow: yellow ?? this.yellow,
    );
  }

  @override
  ThemeExtension<ColorThemeExt> lerp(
    covariant ThemeExtension<ColorThemeExt>? other,
    double t,
  ) {
    return this;
  }
}
