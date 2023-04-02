import 'package:flutter/material.dart';

import '../models/log.dart';
import '../widgets/log_item_widget.dart';

class LogsView extends StatelessWidget {
  final List<Log> logs;
  const LogsView({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        ListView.builder(
          itemCount: logs.length,
          itemBuilder: (context, index) {
            LogItemWidget(logText: "Log $index", logHour: "10:00");
          }
        ),
        // ListView.builder(
        //   itemBuilder: (context, index) => LogItemWidget(logText: "Log ${index+100}", logHour: "10:00"),
        // ),
      ],
    );
  }
}