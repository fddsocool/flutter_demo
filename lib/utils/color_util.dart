import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class AppColors {
  static Color hexFfffff = HexColor('#ffffff');

  //黑色
  static Color hex000000 = HexColor('#000000');
  static Color hex333333 = HexColor('#333333');

  //橘色
  static Color hexDf5549 = HexColor('#df5549');
  static Color hexFf6600 = HexColor('#ff6600');

  //灰色
  static Color hexC2c2c2 = HexColor('#c2c2c2');
  static Color hex666666 = HexColor('#666666');
  static Color hexAa666666 = HexColor('#aa666666');
  static Color hex88Dedede = HexColor('#88dedede');
  static Color hex999999 = HexColor('#999999');
  static Color hexDcdcdc = HexColor('#dcdcdc');
  static Color hexDedede = HexColor('#dedede');
  static Color hexF8f8f8 = HexColor('#f8f8f8');

  //蓝色
  static Color hex2568ff = HexColor('#2568ff');
  static Color hex0057C3 = HexColor('#0057C3');
}
