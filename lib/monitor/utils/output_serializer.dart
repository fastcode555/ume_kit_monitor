/*
 * @Author: your name
 * @Date: 2022-02-20 10:36:45
 * @LastEditTime: 2022-02-22 22:20:21
 * @LastEditors: Please set LastEditors
 * @Description: 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 * @FilePath: /jsonformat/lib/models/output_serial.dart
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ume_kit_monitor/monitor/utils/inner_utils.dart';

/*
JSON数据类型

1. Number：整数或浮点数
2. String：字符串
3. Boolean：true 或 false
4. Array：数组包含在⽅括号[]中
5. Object：对象包含在⼤括号{}中
6. Null：空类型
*/
extension TextSpanHelper on TextSpan {
  TextSpan operator +(TextSpan text) {
    return TextSpan(children: [this, text]);
  }

  TextSpan appendString(String? text) {
    if (text == null) return this;
    return TextSpan(children: [this, TextSpan(text: text, style: style)]);
  }
}

class FormatJSONOutputSerializer {
  String? format(String? json) {
    if (InnerUtils.isJson(json) == false) return null;

    print("========> Start format JSON:\n");

    var data = jsonDecode(json!);
    var output = _formatData(data);

    print("$output\n========> End format JSON:\n");
    return output;
  }

  TextSpan? formatRich(String? json) {
    if (InnerUtils.isJson(json) == false) return null;

    var data = jsonDecode(json!);
    var output = _formatRichData(
      data,
      style: InnerUtils.isMobile()
          ? const JSONOutputStyle()
          : const JSONOutputStyle(fontSize: 18),
    );
    return output;
  }
}

String _lineHeadSpace = "    ";

extension _FormatRich on FormatJSONOutputSerializer {
  /// json格式化输出
  String _formatData(dynamic data, {String box = '', String space = ''}) {
    if (data is Map) {
      box += "{";
      String endSpace = space;
      space += _lineHeadSpace;
      var keys = data.keys.toList();
      for (int i = 0; i < data.length; i++) {
        box += "\n";
        var key = keys[i];
        if (i == data.length - 1) {
          box += space + "\"$key\": " + _formatData(data[key], space: space);
        } else {
          box +=
              space + "\"$key\": " + _formatData(data[key], space: space) + ",";
        }
      }
      box += "\n";
      box += endSpace + "}";
    } else if (data is List) {
      box += "[";
      String endSpace = space;
      space += _lineHeadSpace;
      for (int i = 0; i < data.length; i++) {
        box += "\n";
        var e = data[i];
        if (i == data.length - 1) {
          box += space + _formatData(e, space: space);
        } else {
          box += space + _formatData(e, space: space) + ",";
        }
      }
      box += "\n";
      box += endSpace + "]";
    } else if (data is String) {
      box += "\"$data\"";
    } else if (data is num) {
      box += "$data";
    } else if (data is bool) {
      box += "$data";
    } else {
      box += "null";
    }
    return box;
  }

  TextSpan _formatRichData(
    dynamic data, {
    TextSpan box = const TextSpan(),
    String space = '',
    JSONOutputStyle style = const JSONOutputStyle(),
  }) {
    TextStyle spaceStyle = TextStyle(
      fontSize: style.fontSize,
      fontWeight: style.fontWeight,
      height: style.height,
    );
    if (data is Map) {
      box += TextSpan(
        text: "{",
        style: TextStyle(
          color: style.braceColor,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          height: style.height,
        ),
      );
      String endSpace = space;
      space += _lineHeadSpace;
      var keys = data.keys.toList();
      for (int i = 0; i < data.length; i++) {
        box = box.appendString('\n');
        var key = keys[i];
        TextSpan append = TextSpan(text: space, style: spaceStyle) +
            TextSpan(
              text: "\"$key\"",
              style: TextStyle(
                color: style.keyColor,
                fontSize: style.fontSize,
                fontWeight: style.fontWeight,
                height: style.height,
              ),
            ) +
            TextSpan(
              text: ": ",
              style: TextStyle(
                color: style.colonColor,
                fontSize: style.fontSize,
                fontWeight: style.fontWeight,
                height: style.height,
              ),
            ) +
            _formatRichData(data[key], space: space, style: style);
        if (i == data.length - 1) {
          box += append;
        } else {
          box += append +
              TextSpan(
                text: ",",
                style: TextStyle(
                  color: style.commaColor,
                  fontSize: style.fontSize,
                  fontWeight: style.fontWeight,
                  height: style.height,
                ),
              );
        }
      }
      box = box.appendString('\n');
      box += TextSpan(
        text: endSpace + "}",
        style: TextStyle(
          color: style.braceColor,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          height: style.height,
        ),
      );
    } else if (data is List) {
      box += TextSpan(
        text: "[",
        style: TextStyle(
          color: style.squareBracketsColor,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          height: style.height,
        ),
      );
      String endSpace = space;
      space += _lineHeadSpace;
      for (int i = 0; i < data.length; i++) {
        box = box.appendString('\n');
        var e = data[i];
        if (i == data.length - 1) {
          box += TextSpan(text: space, style: spaceStyle) +
              _formatRichData(e, space: space, style: style);
        } else {
          box += TextSpan(text: space, style: spaceStyle) +
              _formatRichData(e, space: space, style: style) +
              TextSpan(
                text: ",",
                style: TextStyle(
                  color: style.commaColor,
                  fontSize: style.fontSize,
                  fontWeight: style.fontWeight,
                  height: style.height,
                ),
              );
        }
      }
      box = box.appendString('\n');
      box += TextSpan(
        text: endSpace + "]",
        style: TextStyle(
          color: style.squareBracketsColor,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          height: style.height,
        ),
      );
    } else if (data is String) {
      box += TextSpan(
        text: "\"$data\"",
        style: TextStyle(
          color: style.stringColor,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          height: style.height,
        ),
      );
    } else if (data is num) {
      box += TextSpan(
        text: "$data",
        style: TextStyle(
          color: style.numColor,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          height: style.height,
        ),
      );
    } else if (data is bool) {
      box += TextSpan(
        text: "$data",
        style: TextStyle(
          color: style.boolColor,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          height: style.height,
        ),
      );
    } else {
      box += TextSpan(
        text: "null",
        style: TextStyle(
          color: style.nullColor,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          height: style.height,
        ),
      );
    }
    return box;
  }
}

class JSONOutputStyle {
  const JSONOutputStyle(
      {this.commaColor = Colors.black,
      this.squareBracketsColor = Colors.black,
      this.braceColor = Colors.black,
      this.colonColor = Colors.black,
      this.keyColor = Colors.pink,
      this.stringColor = Colors.green,
      this.boolColor = Colors.orange,
      this.numColor = Colors.blue,
      this.nullColor = Colors.brown,
      this.fontSize = 10,
      this.fontWeight = FontWeight.w400,
      this.quotationColor = Colors.black,
      this.height = 1.2});

  /// 字体大小
  final double fontSize;

  /// 字体粗细
  final FontWeight fontWeight;

  /// 行高
  final double height;

  /// 引号颜色
  final Color quotationColor;

  /// 逗号颜色
  final Color commaColor;

  /// 中括号颜色
  final Color squareBracketsColor;

  /// 花括号颜色
  final Color braceColor;

  /// 冒号颜色
  final Color colonColor;

  /// 字典key的颜色
  final Color keyColor;

  /// 字符串的颜色
  final Color stringColor;

  /// 布尔值的颜色
  final Color boolColor;

  /// 数值的颜色
  final Color numColor;

  /// null的颜色
  final Color nullColor;
}
