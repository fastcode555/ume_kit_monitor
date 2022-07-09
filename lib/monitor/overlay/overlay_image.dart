import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ume_kit_monitor/common/imageloader/image_loader.dart';

/// @date 2021/6/5
/// describe:
String _url = '';

class OverlayImg extends StatefulWidget {
  static OverlayEntry? _entry;
  static bool _isShow = false;

  static show(BuildContext? context, String url) {
    _url = url;
    if (_isShow) {
      return;
    }
    if (_entry == null) {
      _entry = OverlayEntry(builder: (context) => OverlayImg());
    }
    Overlay.of(context ?? Get.context!)?.insert(_entry!);
    _isShow = true;
  }

  static hide() {
    if (_entry != null && _isShow) {
      _entry?.remove();
      _isShow = false;
    }
  }

  @override
  _OverlayImgState createState() => _OverlayImgState();
}

class _OverlayImgState extends State<OverlayImg> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => OverlayImg.hide(),
      child: Container(
        color: Colors.black.withOpacity(0.5),
        width: double.infinity,
        height: double.infinity,
        child: ImageLoader.image(_url, fit: BoxFit.fitWidth),
      ),
    );
  }
}
