import 'package:flutter/material.dart';
import 'package:flutter_ume/flutter_ume.dart';

const String _pluginName = 'Monitor';
const String _icon =
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_mini%2Cc_zoom%2Cw_640%2Fimages%2F20170819%2Ff4db5f72c8234b29a60e8e60526d49c9.gif&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1659948148&t=a3384afbdd43424e99633b2ab84f19c4";

class MonitorPlugin implements Pluggable {
  const MonitorPlugin();

  @override
  String get displayName => _pluginName;

  @override
  ImageProvider<Object> get iconImageProvider => NetworkImage(_icon);

  @override
  String get name => _pluginName;

  @override
  void onTrigger() {}

  @override
  Widget buildWidget(BuildContext? context) {
    return Container(
      color: Colors.white,
      width: 100,
      height: 100,
      child: Center(child: Text('Custom Plugin')),
    );
  }
}
