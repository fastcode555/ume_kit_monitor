import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ume_kit_monitor/ext/context_ext.dart';
import 'package:ume_kit_monitor/monitor/awesome_monitor.dart';
import 'package:ume_kit_monitor/monitor/monitor_message_notifier.dart';
import 'package:ume_kit_monitor/monitor/page/monitor_info_detail_page.dart';
import 'package:ume_kit_monitor/utils/navigator_util.dart';
import 'package:ume_kit_monitor/utils/screen_ext.dart';
import 'package:oktoast/oktoast.dart';

/// @date 2020/12/18
/// describe:
int _lastClick = -1;

class ErrorPage extends StatefulWidget {
  final String? tag;

  const ErrorPage({Key? key, this.tag}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    MonitorMessageNotifier<String>? notifier = Monitor.instance.getNotifier(widget.tag);
    return ValueListenableBuilder<List<String>>(
      valueListenable: notifier!.notifier!,
      builder: (_, List<String>? datas, child) {
        return MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
              itemBuilder: (_, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: GestureDetector(
                  onLongPress: () {
                    File file = File(datas![index]);
                    Clipboard.setData(ClipboardData(text: file.readAsStringSync()));
                    showToast('复制成功');
                  },
                  onTap: () {
                    _lastClick = index;
                    NavigatorUtil.pushPage(MonitorInfoDetailPage(fileName: datas![index]));
                  },
                  child: Text(
                    datas?.elementAt(index) ?? '',
                    style: TextStyle(
                      color: _lastClick == index ? context.primaryColor : Colors.white,
                    ),
                  ),
                ),
              ),
              itemCount: datas?.length ?? 0,
            ));
      },
    );
  }
}
