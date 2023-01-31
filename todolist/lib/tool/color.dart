import 'package:flutter/material.dart';

class CustomColors {
  /// 主体色
  static final MaterialColor themeColor = _createMaterialColor(const Color(0xFF000000));

  /// 主背景色
  static const Color mainBgColor = Color(0xFF000000);

  /// 第二背景色
  static const Color secondBgColor = Color(0xFF101010);

  /// 副标题颜色
  static const Color subTitleColor = Color(0xFFA8A8A8);

  /// 复选框颜色 -- 图标色
  static const Color checkBoxColor =  Color(0xFFA8A8A8);

  /// 橙色
  static const Color orangeColor = Color(0xFFFB9909);

  /// 工具方法，生成 MaterialColor
  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;

      int key = (strength * 1000).round();
      Color color = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
      swatch[key] = color;
    }
    return MaterialColor(color.value, swatch);
  }
}

