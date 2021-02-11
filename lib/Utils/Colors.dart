import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color ColorBlackBlue = HexColor('#0a0e0f');
Color ColorBackgroundBlue = HexColor('#151e21');
Color ColorSoftBlue = HexColor('#1780b3');
Color ColorSoftGray = HexColor('#84878a');
Color ColorWhite = HexColor('#cccccc');