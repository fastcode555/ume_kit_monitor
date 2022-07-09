import 'package:flutter/material.dart';
import 'package:ume_kit_monitor/monitor/controller/rich_textediting_controller.dart';

/// @date 25/4/22
/// describe:

class JsonViewerPage extends StatefulWidget {
  final String? api;
  final String? json;

  const JsonViewerPage({Key? key, this.api, this.json}) : super(key: key);

  @override
  _JsonViewerPageState createState() => _JsonViewerPageState();
}

class _JsonViewerPageState extends State<JsonViewerPage> {
  RichTextEditingController _controller = RichTextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.json ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.api}"),
            Text("JsonViewer", style: TextStyle(fontSize: 12)),
          ],
        ),
        centerTitle: false,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return TextField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      maxLines: null,
    );
  }
}
