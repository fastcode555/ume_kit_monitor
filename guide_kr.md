# UME Kit Monitor 가이드

[English](guide.md) | [中文](guide_cn.md) | [Deutsch](guide_de.md) | [Português](guide_pt.md) | [日本語](guide_jp.md) | [한국어](guide_kr.md)

UME Kit Monitor는 네트워크 요청 로깅, 콘솔 출력, 페이지 추적 등의 디버깅 기능을 제공하는 Flutter 디버깅 도구입니다. flutter_ume_plus와 통합되어 사용하기 쉬운 디버깅 인터페이스를 제공합니다.

I. 설치 및 설정
-------------

1. `pubspec.yaml`에 의존성 추가:

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

2. `main.dart`에서 플러그인 등록:

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

3. 앱에서 Monitor 초기화:

```dart
void initState() {
  super.initState();
  Monitor.init(
    context,
    actions: [
      MonitorActionWidget(
        title: "디버그", 
        onTap: () { /* ... */ }
      ),
      // 더 많은 액션 버튼 추가...
    ],
  );
}
```

II. 주요 기능
-----------

1. 콘솔 로그
```dart
// 콘솔 패널에 로그 출력
Monitor.instance.putsConsole(["로그 메시지"]); 
```

2. 네트워크 요청 로그
- 디버깅을 위해 curl 형식으로 네트워크 요청을 자동 기록
- Curl 패널에서 curl 명령어 확인 및 복사 가능

3. JSON 응답 뷰어
```dart
// 접을 수 있는 트리 뷰로 JSON 응답 기록 및 표시
Monitor.instance.put('Response', 'api_name\n$jsonString');
```

4. 페이지 추적
```dart
// 현재 페이지/라우트 자동 추적
Monitor.instance.putPage("현재페이지");
```

5. 사용자 정의 태그 모니터링
```dart
// 사용자 정의 모니터링 패널 생성
Monitor.instance.put('사용자정의태그', '디버그 정보');
```

6. GetX 생명주기 모니터링
- 활성화 시 GetX 위젯 생명주기 자동 추적

III. API 참조
-----------

1. Monitor 클래스
```dart
// 초기화
Monitor.init(context, actions: [...]);

// 핵심 로그 메서드
Monitor.instance.put(String tag, String content)
Monitor.instance.puts(String tag, List<String> contents) 
Monitor.instance.putsConsole(List<String> contents)
Monitor.instance.putPage(String page)
Monitor.instance.putCurl(String curl)

// 로그 지우기
Monitor.instance.clear(String tag)
```

2. MonitorActionWidget
```dart
MonitorActionWidget({
  required String title,
  required VoidCallback onTap,
})
```

IV. 사용 예시
-----------

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
    
    // Monitor 초기화
    Monitor.init(
      context,
      actions: [
        MonitorActionWidget(
          title: "디버그",
          onTap: () { /* ... */ }
        ),
      ],
    );

    // 데이터 기록
    Monitor.instance.putsConsole(["앱 시작됨"]);
    Monitor.instance.put('사용자정의태그', '디버그 정보');
    Monitor.instance.putPage('홈페이지');
  }
}
```

V. 주요 참고사항
-------------

1. Monitor는 릴리스 빌드에서 기본적으로 비활성화됨
2. 태그당 최대 로그 항목은 20개로 제한됨
3. JSON 응답은 자동으로 포맷팅되며 접을 수 있음
4. "ac=last_msg"를 포함하는 ���트워크 요청은 필터링됨 