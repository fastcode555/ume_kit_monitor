# UME Kit Monitor 使用指南

[English](guide.md) | [中文](guide_cn.md) | [Deutsch](guide_de.md) | [Português](guide_pt.md) | [日本語](guide_jp.md) | [한국어](guide_kr.md)

UME Kit Monitor 是一个Flutter调试工具包，提供网络请求日志记录、控制台输出、页面追踪等多种调试功能。它与flutter_ume_plus集成，提供了一个易用的调试界面。

一、安装配置
----------

1. 在`pubspec.yaml`中添加依赖:

```yaml
dependencies:
  ume_kit_monitor: ^2.0.5

dev_dependencies:
  flutter_ume_plus: ^4.0.0
  flutter_ume_kit_ui_plus: ^4.0.0 
  flutter_ume_kit_device_plus: ^4.0.0
  flutter_ume_kit_perf_plus: ^4.0.0
  flutter_ume_kit_show_code_plus: ^4.0.0
  flutter_ume_kit_console_plus: ^4.0.0
```

2. 在`main.dart`中注册插件:

```dart
void main() {
  PluginManager.instance
    ..register(const MonitorPlugin())
    ..register(const MonitorActionsPlugin());
    
  runApp(const UMEWidget(
    enable: true, 
    child: MyApp()
  ));
}
```

3. 在应用中初始化Monitor:

```dart
void initState() {
  super.initState();
  Monitor.init(
    context,
    actions: [
      MonitorActionWidget(
        title: "调试", 
        onTap: () { /* ... */ }
      ),
      // 添加更多操作按钮...
    ],
  );
}
```

二、核心功能
----------

1. 控制台日志
```dart
// 向控制台面板输出日志
Monitor.instance.putsConsole(["日志信息"]); 
```

2. 网络请求日志
- 自动记录网络请求的curl格式，方便调试和复现
- 可以从Curl面板查看��复制curl命令

3. JSON响应查看器
```dart
// 记录和查看JSON响应，支持树形折叠视图
Monitor.instance.put('Response', 'api_name\n$jsonString');
```

4. 页面追踪
```dart
// 自动追踪当前页面/路由
Monitor.instance.putPage("当前页面");
```

5. 自定义标签监控
```dart
// 创建自定义监控面板
Monitor.instance.put('自定义标签', '自定义调试信息');
```

6. GetX生命周期监控
- 启用时自动追踪GetX组件的生命周期

三、API参考
----------

1. Monitor类
```dart
// 初始化
Monitor.init(context, actions: [...]);

// 核心日志方法
Monitor.instance.put(String tag, String content)
Monitor.instance.puts(String tag, List<String> contents) 
Monitor.instance.putsConsole(List<String> contents)
Monitor.instance.putPage(String page)
Monitor.instance.putCurl(String curl)

// 清除日志
Monitor.instance.clear(String tag)
```

2. MonitorActionWidget
```dart
MonitorActionWidget({
  required String title,
  required VoidCallback onTap,
})
```

四、使用示例
----------

```dart
void main() {
  PluginManager.instance
    ..register(const MonitorPlugin())
    ..register(const MonitorActionsPlugin());

  runApp(const UMEWidget(
    enable: true,
    child: MyApp()
  ));
}

class _MyHomePageState extends State<MyHomePage> {
  @override 
  void initState() {
    super.initState();
    
    // 初始化monitor
    Monitor.init(
      context,
      actions: [
        MonitorActionWidget(
          title: "调试",
          onTap: () { /* ... */ }
        ),
      ],
    );

    // 记录一些数据
    Monitor.instance.putsConsole(["应用已启动"]);
    Monitor.instance.put('自定义标签', '调试信息');
    Monitor.instance.putPage('首页');
  }
}
```

五、注意事项
----------

1. Monitor在release构建中默认禁用
2. 每个标签默认最多保存20条日志记录  
3. JSON响应会自动格式化并支持折叠
4. 包含"ac=last_msg"的网络请求会被过滤掉