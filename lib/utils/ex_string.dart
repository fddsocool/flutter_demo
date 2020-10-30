import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

final String regexEmail = '[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}';
final String regexPhone = '^(1)\\d{10}\$';
final String regexURL = '(http|https):\/\/*';

///String扩展
extension SHExtension on String {
  ///16进制string 转 color
  Color toColor() {
    String hex = this.replaceAll('#', '');
    int count = 0;
    switch (hex.length) {
      case 3: // #RGB
      case 4: // #ARGB
        count = 1;
        break;
      case 6: // #RRGGBB
      case 8: // #AARRGGBB
        count = 2;
        break;
      default: // 默认颜色
        return Colors.transparent;
        break;
    }

    List temp = [];
    for (int i = 0; i < hex.length; i += count) {
      String str = hex.substring(i, i + count);
      temp.add(int.parse(str, radix: 16));
    }

    if (temp.length == 3) {
      temp.insert(0, 255);
    }

    return Color.fromRGBO(temp[1], temp[2], temp[3], temp[0] / 255.0);
  }


  /// 判断是否是邮箱
  bool isEmail() {
    return RegExp(regexEmail).hasMatch(this);
  }

  /// 判断是否是手机
  bool isPhone() {
    return RegExp(regexPhone).hasMatch(this);
  }

  /// 判断是否是URL
  bool isURL() {
    return RegExp(regexURL).hasMatch(this);
  }

  /// string 转 int
  int toInt() {
    return int.parse(this);
  }

  /// string 转 double
  double toDouble() {
    return double.parse(this);
  }

  /// string 转bool
  /// (字符串 不等于'true' 不大于0 等于空时 返回false 否则返回true)
  bool toBool() {
    if (this.toLowerCase() == "true" || this.toInt() > 0 || this.toDouble() > 0 || this.trim() != '' || this != '') {
      return true;
    }
    return false;
  }

  /// 编码
  String toCoding() {
    String str = this.toString();
    // 对字符串进行编码
    return jsonEncode(Utf8Encoder().convert(str));
  }

  /// 解码
  String toDeCoding() {
    var list = List<int>();

    /// 字符串解码
    jsonDecode(this).forEach(list.add);
    String value = Utf8Decoder().convert(list);
    return value;
  }

  ///判断是不是为空，对字符串进行trim
  ///为空返回true
  bool isExEmpty({bool trim = true}) {
    if (this == null) {
      return true;
    } else if (this.isEmpty) {
      return true;
    } else {
      if (trim && this.trim().length == 0) {
        return true;
      } else {
        return false;
      }
    }
  }

  /// 去除末尾一个字符
  String removeRightChar() {
    if (this == null) {
      return null;
    } else if (this.length <= 0) {
      return "";
    } else {
      return this.substring(0, this.length - 1);
    }
  }

  /// json写入到file持久化
  void jsonToFile(String path) async {
    File file = File(path);
    try {
      await file.writeAsString(this);
    } catch (e) {
      print('json字符串写入file 报错：$e');
    }
  }
}
