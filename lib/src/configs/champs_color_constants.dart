import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

const primaryColor = Color(0xff5ad83d);
const lightGreen = Color(0xffd1f3cc);
const greyFirst = Color(0xff666666);
const greySecond = Color(0xff484848);
const greyThird = Color(0xff323232);
const greyFourth = Color(0xff2a2a2a);
const whiteColor = Color(0xffffffff);
const greyColor = Color(0xffbdbbb3);
