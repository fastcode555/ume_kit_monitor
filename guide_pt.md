# Guia do UME Kit Monitor

[English](guide.md) | [中文](guide_cn.md) | [Deutsch](guide_de.md) | [Português](guide_pt.md) | [日本語](guide_jp.md) | [한국어](guide_kr.md)

UME Kit Monitor é um kit de ferramentas de depuração Flutter que fornece registro de solicitações de rede, saída de console, rastreamento de páginas e mais recursos de depuração. Ele se integra com flutter_ume_plus para fornecer uma interface de depuração fácil de usar.

I. Instalação e Configuração
-------------------------

1. Adicione as dependências ao `pubspec.yaml`:

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

2. Registre os plugins em `main.dart`:

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

3. Inicialize o Monitor em seu aplicativo:

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
      // Adicione mais botões de ação...
    ],
  );
}
```

II. Recursos Principais
--------------------

1. Registro do Console
```dart
// Enviar logs para o painel do console
Monitor.instance.putsConsole(["Mensagem de log"]); 
```

2. Registro de Solicitações de Rede
- Registra automaticamente solicitações de rede no formato curl para depuração fácil
- Visualize e copie comandos curl do painel Curl

3. Visualizador de Resposta JSON
```dart
// Registrar e visualizar respostas JSON com visualização em árvore recolhível
Monitor.instance.put('Response', 'api_name\n$jsonString');
```

4. Rastreamento de Página
```dart
// Rastrear automaticamente a página/rota atual
Monitor.instance.putPage("PáginaAtual");
```

5. Monitoramento de Tag Personalizada
```dart
// Criar painéis de monitoramento personalizados
Monitor.instance.put('TagPersonalizada', 'Informação de depuração');
```

6. Monitoramento do Ciclo de Vida GetX
- Rastreia automaticamente ciclos de vida de widgets GetX quando ativado

III. Referência da API
-------------------

1. Classe Monitor
```dart
// Inicialização
Monitor.init(context, actions: [...]);

// Métodos principais de registro
Monitor.instance.put(String tag, String content)
Monitor.instance.puts(String tag, List<String> contents) 
Monitor.instance.putsConsole(List<String> contents)
Monitor.instance.putPage(String page)
Monitor.instance.putCurl(String curl)

// Limpar logs
Monitor.instance.clear(String tag)
```

2. MonitorActionWidget
```dart
MonitorActionWidget({
  required String title,
  required VoidCallback onTap,
})
```

IV. Exemplo de Uso
----------------

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
    
    // Inicializar monitor
    Monitor.init(
      context,
      actions: [
        MonitorActionWidget(
          title: "Debug",
          onTap: () { /* ... */ }
        ),
      ],
    );

    // Registrar alguns dados
    Monitor.instance.putsConsole(["Aplicativo iniciado"]);
    Monitor.instance.put('TagPersonalizada', 'Informação de depuração');
    Monitor.instance.putPage('PáginaInicial');
  }
}
```

V. Notas Importantes
-----------------

1. O Monitor está desativado por padrão em builds de release
2. O número máximo de entradas de log por tag é limitado a 20
3. As respostas JSON são formatadas automaticamente e podem ser recolhidas
4. Solicitações de rede contendo "ac=last_msg" são filtradas 