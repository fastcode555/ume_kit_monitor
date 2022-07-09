import 'package:flutter/material.dart';
import 'package:ume_kit_monitor/monitor/utils/inner_utils.dart';
import 'package:ume_kit_monitor/monitor/utils/output_serializer.dart';

class RichTextEditingController extends TextEditingController {
  /// 高亮显示
  bool highlight = true;

  /// 格式化富文本
  final FormatJSONOutputSerializer _serializer = FormatJSONOutputSerializer();

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    if (highlight) {
      TextSpan? text;
      if (InnerUtils.isEmpty(this.text)) {
        text = _serializer.formatRich(this.text) ?? const TextSpan();
      }
      return text ?? const TextSpan();
    }
    String json = value.text;
    return TextSpan(text: json, style: style);
  }
}
