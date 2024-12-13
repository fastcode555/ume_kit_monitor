# UME Kit Monitor Guide

[English](guide.md) | [中文](guide_cn.md) | [Deutsch](guide_de.md) | [Português](guide_pt.md) | [日本語](guide_jp.md) | [한국어](guide_kr.md)

UME Kit Monitor is a Flutter debugging toolkit that provides network request logging, console output, page tracking and more debugging features. It integrates with flutter_ume_plus to provide an easy-to-use debugging interface.

I. Installation & Setup
--------------------

1. Add dependencies to `pubspec.yaml`:

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

2. Register plugins in `main.dart`:

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

3. Initialize Monitor in your app:

```dart
void initState() {
  super.initState();
  Monitor.init(
    context,
    actions: [
      MonitorActionWidget(
        title: "Debug", 
        onTap: () { /* ... */ }
      ),
      // Add more action buttons...
    ],
  );
}
```

II. Core Features
---------------

1. Console Logging
```dart
// Output logs to console panel
Monitor.instance.putsConsole(["Log message"]); 
```

2. Network Request Logging
- Automatically records network requests in curl format for easy debugging
- View and copy curl commands from the Curl panel

3. JSON Response Viewer
```dart
// Log and view JSON responses with collapsible tree view
Monitor.instance.put('Response', 'api_name\n$jsonString');
```

4. Page Tracking
```dart
// Automatically track current page/route
Monitor.instance.putPage("CurrentPage");
```

5. Custom Tag Monitoring
```dart
// Create custom monitoring panels
Monitor.instance.put('CustomTag', 'Custom debug info');
```

6. GetX Lifecycle Monitoring
- Automatically tracks GetX widget lifecycles when enabled

III. API Reference
----------------

1. Monitor Class
```dart
// Initialization
Monitor.init(context, actions: [...]);

// Core logging methods
Monitor.instance.put(String tag, String content)
Monitor.instance.puts(String tag, List<String> contents) 
Monitor.instance.putsConsole(List<String> contents)
Monitor.instance.putPage(String page)
Monitor.instance.putCurl(String curl)

// Clear logs
Monitor.instance.clear(String tag)
```

2. MonitorActionWidget
```dart
MonitorActionWidget({
  required String title,
  required VoidCallback onTap,
})
```

IV. Usage Example
---------------

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
    
    // Initialize monitor
    Monitor.init(
      context,
      actions: [
        MonitorActionWidget(
          title: "Debug",
          onTap: () { /* ... */ }
        ),
      ],
    );

    // Log some data
    Monitor.instance.putsConsole(["App started"]);
    Monitor.instance.put('CustomTag', 'Debug info');
    Monitor.instance.putPage('HomePage');
  }
}
```

V. Important Notes
----------------

1. Monitor is disabled by default in release builds
2. Maximum log entries per tag is limited to 20
3. JSON responses are automatically formatted and collapsible
4. Network requests containing "ac=last_msg" are filtered out 