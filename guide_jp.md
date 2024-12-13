# UME Kit Monitor ガイド

[English](guide.md) | [中文](guide_cn.md) | [Deutsch](guide_de.md) | [Português](guide_pt.md) | [日本語](guide_jp.md) | [한국어](guide_kr.md)

UME Kit Monitorは、ネットワークリクエストのログ記録、コンソール出力、ページトラッキングなどのデバッグ機能を提供するFlutterデバッグツールキットです。flutter_ume_plusと統合して、使いやすいデバッグインターフェースを提供します。

I. インストールと設定
------------------

1. `pubspec.yaml`に依存関係を追加:

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

2. `main.dart`でプラグインを登録:

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

3. アプリでMonitorを初期化:

```dart
void initState() {
  super.initState();
  Monitor.init(
    context,
    actions: [
      MonitorActionWidget(
        title: "デバッグ", 
        onTap: () { /* ... */ }
      ),
      // アクションボタンを追加...
    ],
  );
}
```

II. 主な機能
----------

1. コンソールログ
```dart
// コンソールパネルにログを出力
Monitor.instance.putsConsole(["ログメッセージ"]); 
```

2. ネットワークリクエストログ
- デバッグ用にcurl形式でネットワークリクエストを自動記録
- Curlパネルからcurlコマンドを表示・コピー可能

3. JSONレスポンスビューア
```dart
// 折りたたみ可能なツリービューでJSONレスポンスを記録・表示
Monitor.instance.put('Response', 'api_name\n$jsonString');
```

4. ページトラッキング
```dart
// 現在のページ/ルートを自動追跡
Monitor.instance.putPage("現在のページ");
```

5. カスタムタグモニタリング
```dart
// カスタムモニタリングパネルを作成
Monitor.instance.put('カスタムタグ', 'デバッグ情報');
```

6. GetXライフサイクルモニタリング
- 有効時にGetXウィジェットのライフサイクルを自動追跡

III. APIリファレンス
-----------------

1. Monitorクラス
```dart
// 初期化
Monitor.init(context, actions: [...]);

// コアログメソッド
Monitor.instance.put(String tag, String content)
Monitor.instance.puts(String tag, List<String> contents) 
Monitor.instance.putsConsole(List<String> contents)
Monitor.instance.putPage(String page)
Monitor.instance.putCurl(String curl)

// ログのクリア
Monitor.instance.clear(String tag)
```

2. MonitorActionWidget
```dart
MonitorActionWidget({
  required String title,
  required VoidCallback onTap,
})
```

IV. 使用例
---------

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
    
    // Monitorを初期化
    Monitor.init(
      context,
      actions: [
        MonitorActionWidget(
          title: "デバッグ",
          onTap: () { /* ... */ }
        ),
      ],
    );

    // データを記録
    Monitor.instance.putsConsole(["アプリ起動"]);
    Monitor.instance.put('カスタムタグ', 'デバッグ情報');
    Monitor.instance.putPage('ホームページ');
  }
}
```

V. 重要な��意事項
--------------

1. Monitorはリリースビルドではデフォルトで無効
2. タグごとの最大ログエントリは20に制限
3. JSONレスポンスは自動的にフォーマットされ、折りたたみ可能
4. "ac=last_msg"を含むネットワークリクエストはフィルタリング 