import 'package:flutter/material.dart';

import '../widgets/log_item_widget.dart';

class LogsView extends StatelessWidget {
  const LogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        ListView.builder(
          itemBuilder: (context, index) => LogItemWidget(logText: "Log $index", logHour: "10:00"),
        ),
        ListView.builder(
          itemBuilder: (context, index) => LogItemWidget(logText: "Log ${index+100}", logHour: "10:00"),
        ),
      ],
    );
  }
}