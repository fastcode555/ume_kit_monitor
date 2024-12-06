import 'package:flutter/material.dart';
import 'package:flutter_ume_kit_perf_plus/flutter_ume_kit_perf_plus.dart';
import 'package:flutter_ume_plus/flutter_ume_plus.dart';
import 'package:ume_kit_monitor/ume_kit_monitor.dart';

void main() {
  PluginManager.instance
    ..register(const MonitorPlugin())
    ..register(const MonitorActionsPlugin())
    ..register(Performance());
  runApp(const UMEWidget(child: MyApp())); // 初始化
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
  final json = '''
  {
  "username":"Barry",
  "gender":"male",
  "bio":"haaaaaaaaa",
  "birthday":"1995-07-26T00:00:00.000Z",
  "loginMethod":"google",
  "nickname":"Barry",
  "avatar":"https://dev.e-play.online/api/v2/assets/users/avatar/1730780140899-1730780138786.jpg",
  "isActive":true,
  "profileFilled":true,
  "ipAddress":"Cambodia",
  "id":10609,
  "phone":null,
  "phoneCountry":null,
  "email":"barry018.infinity@gmail.com.bk",
  "following":"6",
  "follower":"8",
  "blacklist":"1",
  "tags":[
    {
      "id":1,
      "code":"jazz",
      "name":"JAZZ"
    },
    {
      "id":10,
      "code":"dance",
      "name":"DANCE"
    },
    {
      "id":13,
      "code":"metal",
      "name":"METAL"
    }
  ]
}
      ''';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Monitor.init(
        context,
        actions: [
          MonitorActionWidget(title: 'DebugPage', onTap: () {}),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Monitor.instance.put("Response", "here the response");
                Monitor.instance.put("Response", json);
                Monitor.instance.put("Json", json);
              },
              child: const Text('Click me to show the log'),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
