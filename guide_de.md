# UME Kit Monitor Anleitung

[English](guide.md) | [中文](guide_cn.md) | [Deutsch](guide_de.md) | [Português](guide_pt.md) | [日本語](guide_jp.md) | [한국어](guide_kr.md)

UME Kit Monitor ist ein Flutter-Debugging-Toolkit, das Netzwerkanfragen-Protokollierung, Konsolenausgabe, Seiten-Tracking und weitere Debugging-Funktionen bietet. Es integriert sich mit flutter_ume_plus, um eine benutzerfreundliche Debugging-Oberfläche bereitzustellen.

I. Installation & Einrichtung
--------------------------

1. Fügen Sie die Abhängigkeiten in `pubspec.yaml` hinzu:

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

2. Registrieren Sie die Plugins in `main.dart`:

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

3. Initialisieren Sie Monitor in Ihrer App:

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
      // Fügen Sie weitere Aktionsschaltflächen hinzu...
    ],
  );
}
```

II. Kernfunktionen
----------------

1. Konsolen-Protokollierung
```dart
// Protokolle an das Konsolenpanel ausgeben
Monitor.instance.putsConsole(["Protokollnachricht"]); 
```

2. Netzwerkanfragen-Protokollierung
- Zeichnet automatisch Netzwerkanfragen im curl-Format für einfaches Debugging auf
- Anzeigen und Kopieren von curl-Befehlen aus dem Curl-Panel

3. JSON-Antwort-Viewer
```dart
// Protokollieren und Anzeigen von JSON-Antworten mit ausklappbarer Baumansicht
Monitor.instance.put('Response', 'api_name\n$jsonString');
```

4. Seiten-Tracking
```dart
// Automatisches Tracking der aktuellen Seite/Route
Monitor.instance.putPage("AktuelleSeite");
```

5. Benutzerdefinierte Tag-Überwachung
```dart
// Erstellen Sie benutzerdefinierte Überwachungspanels
Monitor.instance.put('BenutzerdefiniertesTag', 'Debug-Info');
```

6. GetX Lebenszyklus-Überwachung
- Verfolgt automatisch GetX-Widget-Lebenszyklen, wenn aktiviert

III. API-Referenz
---------------

1. Monitor-Klasse
```dart
// Initialisierung
Monitor.init(context, actions: [...]);

// Kern-Protokollierungsmethoden
Monitor.instance.put(String tag, String content)
Monitor.instance.puts(String tag, List<String> contents) 
Monitor.instance.putsConsole(List<String> contents)
Monitor.instance.putPage(String page)
Monitor.instance.putCurl(String curl)

// Protokolle löschen
Monitor.instance.clear(String tag)
```

2. MonitorActionWidget
```dart
MonitorActionWidget({
  required String title,
  required VoidCallback onTap,
})
```

IV. Verwendungsbeispiel
---------------------

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
    
    // Monitor initialisieren
    Monitor.init(
      context,
      actions: [
        MonitorActionWidget(
          title: "Debug",
          onTap: () { /* ... */ }
        ),
      ],
    );

    // Daten protokollieren
    Monitor.instance.putsConsole(["App gestartet"]);
    Monitor.instance.put('BenutzerdefiniertesTag', 'Debug-Info');
    Monitor.instance.putPage('Startseite');
  }
}
```

V. Wichtige Hinweise
------------------

1. Monitor ist standardmäßig in Release-Builds deaktiviert
2. Maximale Protokolleinträge pro Tag sind auf 20 begrenzt
3. JSON-Antworten werden automatisch formatiert und sind zusammenklappbar
4. Netzwerkanfragen, die "ac=last_msg" enthalten, werden gefiltert 