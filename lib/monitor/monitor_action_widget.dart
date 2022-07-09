import 'package:flutter/material.dart';
import 'package:ume_kit_monitor/monitor/overlay/overlay_action_panel.dart';
import 'package:ume_kit_monitor/utils/screen_ext.dart';

/// @date 4/21/21
/// describe:
class MonitorActionWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;
  final String? title;

  const MonitorActionWidget({
    Key? key,
    this.onTap,
    this.child,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
        OverlayActionPanel.hide();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black.withOpacity(0.7),
        ),
        child: child ?? _defaultWidget(),
      ),
    );
  }

  _defaultWidget() {
    return Text(
      title ?? '',
      style: TextStyle(color: Colors.white),
    );
  }
}
