import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ume_kit_monitor/monitor/page/log_recorder_detail_page.dart';
import 'package:ume_kit_monitor/monitor/utils/file_utils.dart';
import 'package:ume_kit_monitor/monitor/utils/inner_utils.dart';
import 'package:ume_kit_monitor/monitor/widgets/base_scaffold.dart';

/// @date 10/9/21
/// describe:

class LogRecorderPage extends StatefulWidget {
  static const String routeName = "/page/LogRecorderPage";

  @override
  _LogRecorderPageState createState() => _LogRecorderPageState();
}

class _LogRecorderPageState extends State<LogRecorderPage> {
  List<FileSystemEntity>? _files;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FileUtils.getAppDirectory().then((dirs) {
        Directory dir = Directory("${dirs.path}LogRecorder");
        if (dir.existsSync()) {
          _files = dir.listSync();
          if (_files != null && _files!.isNotEmpty) {
            setState(() {});
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Log Recorder",
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      removeBottom: true,
      context: context,
      child: ListView.separated(
        itemBuilder: (_, index) => _buildItem(_files![index] as File),
        separatorBuilder: _sepratorItem,
        itemCount: _files?.length ?? 0,
      ),
    );
  }

  Widget _sepratorItem(BuildContext context, int index) => Divider(thickness: 1, height: 1, color: Colors.white);

  _buildItem(File file) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(LogRecorderDetailPage.routeName, arguments: file),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        height: 100,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${file.name}", style: TextStyle(fontSize: 16, color: Colors.white)),
                  GestureDetector(
                    child: Text("${file.path}", style: TextStyle(fontSize: 10, color: Colors.white)),
                    onLongPress: () {
                      Share.shareXFiles([XFile(file.path)], text: file.name);
                    },
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                file.delete();
                _files?.remove(file);
                setState(() {});
              },
              icon: Icon(Icons.delete_forever, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
