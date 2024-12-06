import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ume_kit_monitor/monitor/page/exception_recorder_page.dart';
import 'package:ume_kit_monitor/monitor/page/home_page.dart';
import 'package:ume_kit_monitor/monitor/page/log_recorder_page.dart';
import 'package:ume_kit_monitor/monitor/page/monitor_info_detail_page.dart';
import 'package:ume_kit_monitor/monitor/widgets/icon_btn.dart';

import '../page/log_recorder_detail_page.dart';

/// @date 2020/12/17
/// describe:悬浮面板
class OverlayPane extends StatefulWidget {
  @override
  _OverlayPaneState createState() => _OverlayPaneState();
}

class _OverlayPaneState extends State<OverlayPane> {
  bool _isFullScreen = false;

  double get _statusHeight => _isFullScreen ? MediaQuery.of(context).padding.top : 0;

  @override
  Widget build(BuildContext context) {
    double height = window.physicalSize.height / MediaQuery.of(context).devicePixelRatio;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.black.withOpacity(0.7),
            height: height / (_isFullScreen ? 1 : 2) - _statusHeight,
            width: double.infinity,
            child: Stack(
              children: [
                _buildNavigator(),
                SizedBox(
                  height: kToolbarHeight,
                  child: Row(
                    children: [
                      const Spacer(),
                      IconBtn(
                        _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                        onTap: () {
                          setState(() => _isFullScreen = !_isFullScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigator() {
    return Navigator(
      initialRoute: HomePage.routeName,
      onGenerateRoute: (RouteSettings settins) {
        late WidgetBuilder builder;
        switch (settins.name) {
          case HomePage.routeName:
            builder = (context) => HomePage();
            break;
          case ExceptionRecorderPage.routeName:
            builder = (context) => ExceptionRecorderPage();
            break;
          case LogRecorderDetailPage.routeName:
            builder = (context) => LogRecorderDetailPage(settins.arguments as File);
            break;
          case LogRecorderPage.routeName:
            builder = (context) => LogRecorderPage();
            break;
          case MonitorInfoDetailPage.routeName:
            builder = (context) => MonitorInfoDetailPage();
            break;
        }
        return MaterialPageRoute(builder: builder);
      },
    );
  }
}
