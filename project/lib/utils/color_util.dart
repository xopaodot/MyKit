import 'dart:ui';

class ColorUtil {
  static Color fromHex(String? code) {
    //先判断是否符合#RRGGBB的要求如果不符合给一个默认颜色
    if (code==null||code==""|| code.length != 7) {
      return const Color(0xFFFFFFFF); //定了一个默认的主题色常量
    }
    // #rrggbb 获取到RRGGBB转成16进制 然后在加上FF的透明度
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
  /// 颜色检测只保存 #RRGGBB格式 FF透明度
  /// [color] 格式可能是材料风/十六进制/string字符串
  /// 返回[String] #rrggbb 字符串
  static String? color2HEX(Object color) {
    if (color is Color) {
      // 0xFFFFFFFF
      //将十进制转换成为16进制 返回字符串但是没有0x开头
      String temp = color.value.toRadixString(16);
      color = "#" + temp.substring(2, 8);
    }
    return color.toString();
  }
}