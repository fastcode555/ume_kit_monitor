import 'package:dio_log/http_log_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:ume_kit_monitor/monitor/awesome_monitor.dart';
import 'package:ume_kit_monitor/monitor/monitor_action_widget.dart';
import 'package:ume_kit_monitor/monitor/overlay/overlay_icon.dart';
import 'package:ume_kit_monitor/monitor/overlay/overlay_pane.dart';
import 'package:ume_kit_monitor/monitor/page/exception_recorder_page.dart';
import 'package:ume_kit_monitor/utils/navigator_util.dart';

/// @date 4/21/21
/// describe:
class OverlayActionPanel extends StatefulWidget {
  static OverlayEntry? _entry;
  static bool _isShow = false;

  static bool get isShow => _isShow;

  static show(BuildContext context) {
    if (_isShow) {
      return;
    }
    if (_entry == null) {
      _entry = OverlayEntry(builder: (context) => OverlayActionPanel());
    }
    Overlay.of(context)?.insert(_entry!);
    _isShow = true;
  }

  static hide() {
    if (_entry != null && _isShow) {
      _entry?.remove();
      _isShow = false;
    }
  }

  @override
  _OverlayActionPanelState createState() => _OverlayActionPanelState();
}

class _OverlayActionPanelState extends State<OverlayActionPanel> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Wrap(
            runSpacing: 4,
            spacing: 4,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              if (Monitor.instance.actions != null) ...?Monitor.instance.actions,
              MonitorActionWidget(
                title: 'ExceptionRecorder',
                onTap: () => NavigatorUtil.pushPage(ExceptionRecorderPage()),
              ),
              MonitorActionWidget(
                title: 'HttpLog',
                onTap: () => NavigatorUtil.pushPage(HttpLogListWidget()),
              ),
              MonitorActionWidget(
                title: 'Close Monitor',
                onTap: () {
                  OverlayPane.hide();
                  hideFloating();
                },
              ),
              MonitorActionWidget(
                child: Icon(Icons.close, color: Colors.white),
                onTap: () => OverlayActionPanel.hide(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
