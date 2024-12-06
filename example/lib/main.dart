import 'package:flutter/material.dart';
import 'package:flutter_ume_plus/flutter_ume_plus.dart'; // UME 框架
import 'package:flutter_ume_kit_console_plus/flutter_ume_kit_console_plus.dart'; // debugPrint 插件包
import 'package:flutter_ume_kit_device_plus/flutter_ume_kit_device_plus.dart'; // 设备信息插件包
import 'package:flutter_ume_kit_perf_plus/flutter_ume_kit_perf_plus.dart'; // 性能插件包
import 'package:flutter_ume_kit_show_code_plus/flutter_ume_kit_show_code_plus.dart'; // 代码查看插件包
import 'package:flutter_ume_kit_ui_plus/flutter_ume_kit_ui_plus.dart'; // UI 插件包
import 'package:ume_kit_monitor/ume_kit_monitor.dart';

import 'consts.dart';

void main() {
  PluginManager.instance
    ..register(const MonitorPlugin())
    ..register(const MonitorActionsPlugin())
    ..register(const WidgetInfoInspector())
    ..register(const WidgetDetailInspector())
    ..register(const ColorSucker())
    ..register(AlignRuler())
    ..register(const ColorPicker()) // 新插件
    ..register(const TouchIndicator()) // 新插件
    ..register(Performance())
    ..register(const ShowCode())
    ..register(const MemoryInfoPage())
    ..register(CpuInfoPage())
    ..register(const DeviceInfoPanel())
    ..register(Console());
  runApp(const UMEWidget(enable: true, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Monitor.init(
        context,
        actions: [
          MonitorActionWidget(title: "DebugPage", onTap: () {}),
          MonitorActionWidget(title: "Dialog Page", onTap: () {}),
          MonitorActionWidget(title: "Test Page", onTap: () {}),
        ],
      );
      Monitor.instance.putsConsole(["当前Ids：....."]);
      Monitor.instance.put('AesDecode', 'testApi\n$jsonString');
      Monitor.instance.put('Response', 'testApi\n$jsonString');
      Monitor.instance.put('json', 'testApi\n$jsonString');
      Monitor.instance.put('test', 'here is a demo');
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
