import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ume_kit_monitor/common/imageloader/image_loader.dart';
import 'package:ume_kit_monitor/monitor/overlay/overlay_action_panel.dart';
import 'package:ume_kit_monitor/monitor/overlay/overlay_pane.dart';

/// @date 2020/12/17
/// describe:

bool show = false;
Offset offset = Offset(0, 200);
var ICON =
    'https://nimg.ws.126.net/?url=http%3A%2F%2Fimg5.cache.netease.com%2Fgame%2F2015%2F1%2F4%2F20150104113130164b1_550.jpg&thumbnail=660x2147483647&quality=80&type=jpg';

final double radius = 50;
var entry = OverlayEntry(
  builder: (context) => Stack(
    children: <Widget>[
      Positioned(
        left: offset.dx,
        top: offset.dy,
        child: _buildFloating(context),
      ),
    ],
  ),
);

///绘制悬浮控件
_buildFloating(BuildContext context) => GestureDetector(
      onPanDown: (details) {
        offset = details.globalPosition - Offset(radius / 2, radius / 2);
        entry.markNeedsBuild();
      },
      onPanUpdate: (DragUpdateDetails details) {
        offset = offset + details.delta;
        entry.markNeedsBuild();
      },
      onTap: () {
        if (OverlayPane.isShow || OverlayActionPanel.isShow) {
          OverlayPane.hide();
          OverlayActionPanel.hide();
        } else {
          OverlayPane.show(context);
        }
      },
      onLongPress: () {
        _onLongPress(context);
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: radius,
          width: radius,
          alignment: Alignment.center,
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.white, offset: Offset(-1.0, -1.0), blurRadius: 4.0),
                BoxShadow(color: Colors.black.withOpacity(0.6), offset: Offset(1.0, 1.0), blurRadius: 3.0),
              ],
            ),
            child: ImageLoader.circle(ICON, radius: radius),
          ),
        ),
      ),
    );

showFloating(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    if (!show) {
      Overlay.of(context)?.insert(entry);
      show = true;
    }
  });
}

hideFloating() {
  if (show) {
    entry.remove();
    show = false;
  }
}

void _onLongPress(BuildContext context) {
  OverlayActionPanel.show(context);
}
