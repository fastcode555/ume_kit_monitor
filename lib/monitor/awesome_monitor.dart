import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ume_kit_monitor/monitor/error_info_proccessor.dart';
import 'package:ume_kit_monitor/monitor/monitor_action_widget.dart';
import 'package:ume_kit_monitor/monitor/monitor_message_notifier.dart';

import 'overlay/overlay_icon.dart';

/// @date 2020/11/25
/// describe:
class Monitor {
  //force init variant
  static const int CLICK_MAX_COUNT = 3;
  static const String MONITOR_TAG = "MONITOR_TAGS";
  static Map<int, int> clickCounters = Map();

  Map<String, MonitorMessageNotifier<String>> _maps = Map();
  static List<MonitorActionWidget>? _actions;

  List<MonitorActionWidget>? get actions => _actions;

  static bool _enable = CoreConfig.debug;

  static Monitor? _instance;

  List<String> get tabs => _maps.keys.toList();

  factory Monitor() => _getInstance();

  static Monitor get instance => _getInstance();

  static Monitor _getInstance() {
    if (_instance == null) {
      _instance = Monitor._internal();
    }
    return _instance!;
  }

  //to force init monitor to look for details
  static void forceInit(int mark, BuildContext context) {
    if (mark != 0 && mark != 1) {
      return;
    }

    int? clickCount = clickCounters[mark];
    clickCount = clickCount == null ? 1 : clickCount + 1;
    clickCounters[mark] = clickCount;
    bool forceInitMonitor = clickCounters[0] != null &&
        clickCounters[0]! >= CLICK_MAX_COUNT &&
        (clickCounters[1] != null && clickCounters[1]! >= CLICK_MAX_COUNT);
    if (forceInitMonitor) {
      _enable = true;
      clickCounters.clear();
      showToast("will force init the monitor!!!");
      SpUtil.putBool(MONITOR_TAG, true);
      if (_actions != null) {
        Monitor.instance.addActions(_actions!);
      }
      Monitor.instance._putLastErrorFile();
      Monitor.instance.show(context);
    }
  }

  static void init(BuildContext context, {List<MonitorActionWidget>? actions, bool? forceInit}) async {
    if (forceInit != null && forceInit) {
      CoreConfig.debug = forceInit;
    }
    _enable = CoreConfig.debug || await SpUtil.getBool(Monitor.MONITOR_TAG)!;
    if (_enable) {
      Monitor.instance.show(context);
      Monitor.instance.addActions(actions);
    } else {
      _actions = actions;
    }
  }

  void addActions(List<MonitorActionWidget>? actions) {
    if (_enable) {
      if (_actions != null && actions != null && _actions != actions) {
        _actions?.addAll(actions);
      } else {
        _actions = actions;
      }
    }
  }

  Monitor._internal() {
    if (_enable) {
      _putLastErrorFile();
    }
  }

  MonitorMessageNotifier<String>? getNotifier(String? tag) => _maps[tag];

  void put(String tag, String content, {bool limit = true}) {
    //屏蔽掉刷屏的请求
    if (content.contains("ac=last_msg")) {
      return;
    }
    if (!_enable) {
      return;
    }
    if (InnerUtils.isEmpty(tag)) {
      return;
    }
    MonitorMessageNotifier<String>? notifier = _maps[tag];
    if (notifier == null) {
      notifier = MonitorMessageNotifier<String>();
      _maps[tag] = notifier;
    }
    notifier.add(content, limit: limit);
  }

  void puts(String tag, List<String> contents, {bool limit = true}) {
    if (contents.isEmpty) return;
    for (String content in contents) {
      put(tag, content, limit: limit);
    }
  }

  void putsConsole(List<String> contents, {bool limit = true}) {
    if (contents.isEmpty) return;
    for (String content in contents) {
      put('Console', content, limit: limit);
    }
  }

  void putPage(String page) => put("Page", page);

  void putSocket(String page) => put("Socket", page);

  void putCurl(String curl) => put("Curl", curl);

  void putLogCat(String msg) => put("LogCat", msg);

  void show(BuildContext context) => showFloating(context);

  void clear(String tag) {
    if ('Error' == tag) {
      _maps[tag]?.message?.forEach((element) {
        File file = File(element);
        if (file.existsSync()) {
          file.delete();
        }
      });
    }
    _maps[tag]?.clear();
  }

  void putError(String line) async {
    if (_enable && GetPlatform.isMobile) {
      Directory dir = await FileUtils.getAppDirectory();
      DateTime date = DateTime.now();
      File file = File(
          '${dir.path}error/${DateUtil.formatDate(date, format: 'yyyy_MM_dd_HH_mm_ss')}${DateUtil.getNowDateMs()}');
      String? _errorHeader = await ErrorInfoProcessor.getDeviceInfo();
      await file.create();
      await file.writeAsString('$_errorHeader\n$line');
      put("Error", file.path, limit: false);
      debugPrint(line);
    }
  }

  //将上次所有的错误文件放入到集合中
  void _putLastErrorFile() async {
    try {
      if (_enable && GetPlatform.isMobile) {
        Directory directory = await FileUtils.getAppDirectory();
        directory = new Directory('${directory.path}error/');
        if (!directory.existsSync()) {
          await directory.create();
        } else {
          List<FileSystemEntity> files = directory.listSync();
          for (var f in files) {
            if (FileSystemEntity.isFileSync(f.path)) {
              put('Error', f.path, limit: false);
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
