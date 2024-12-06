import 'package:flutter/material.dart';
import 'package:ume_kit_monitor/monitor/awesome_monitor.dart';
import 'package:ume_kit_monitor/monitor/page/curl_page.dart';
import 'package:ume_kit_monitor/monitor/widgets/icon_btn.dart';

import 'exception_recorder_page.dart';

/// @date 2020/12/17
/// describe:悬浮面板
class HomePage extends StatefulWidget {
  static const String routeName = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

int _lastSelectPage = -1;

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    List<String> tabs = Monitor.instance.tabs;
    if (_tabController == null || _tabController?.length != tabs.length) {
      if (_lastSelectPage < 0) {
        _lastSelectPage = tabs.indexOf('Curl');
        _lastSelectPage = _lastSelectPage >= 0 ? _lastSelectPage : 0;
      }
      _tabController = TabController(length: tabs.length, vsync: this, initialIndex: _lastSelectPage);
      _tabController?.addListener(() {
        _lastSelectPage = _tabController?.index ?? 0;
      });
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.black.withOpacity(0.7),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: kToolbarHeight,
                  child: Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          tabAlignment: TabAlignment.start,
                          controller: _tabController,
                          indicatorColor: Colors.white,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white,
                          unselectedLabelStyle: TextStyle(color: Colors.white),
                          labelPadding: EdgeInsets.symmetric(horizontal: 8),
                          isScrollable: true,
                          tabs: tabs.map((e) => Tab(text: e)).toList(),
                        ),
                      ),
                      IconBtn(
                        Icons.delete,
                        onTap: () => Monitor.instance.clear(tabs[_tabController?.index ?? 0]),
                      ),
                      IconBtn(
                        Icons.error,
                        onTap: () => Navigator.of(context).pushNamed(ExceptionRecorderPage.routeName),
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: tabs.map(_buildPage).toList(),
                    controller: _tabController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPage(String tag) {
    return CurlPage(tag: tag);
  }
}
