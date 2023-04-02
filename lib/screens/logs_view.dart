import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/log.dart';
import '../widgets/log_item_widget.dart';

class LogsView extends StatefulWidget {
  final Map<String, List<Log>> organizedLogs;
  const LogsView({super.key, required this.organizedLogs});

  @override
  State<LogsView> createState() => _LogsViewState();
}

class _LogsViewState extends State<LogsView> {
  final List<int> _days = [1, 2, 3, 4, 5, 6, 7];
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _days.length,
        itemBuilder: (BuildContext context, int index) {
          final day = _days[index].toString();
          final logs = widget.organizedLogs[day] ?? [];

          return logs.isNotEmpty
              ? ListView.builder(
            itemCount: logs.length,
            itemBuilder: (BuildContext context, int index) {
              final log = logs[index];
              return LogItemWidget(logText: log.id.toString(), logHour: log.date.toString());
            },
          )
              : Center(
            child: Text('No logs for this day'),
          );
        },
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return PageView(
  //     children: <Widget>[
  //       ListView.builder(
  //         itemCount: widget.logs.length,
  //         itemBuilder: (context, index) {
  //           LogItemWidget(logText: "Log $index", logHour: "10:00");
  //         }
  //       ),
  //       // ListView.builder(
  //       //   itemBuilder: (context, index) => LogItemWidget(logText: "Log ${index+100}", logHour: "10:00"),
  //       // ),
  //     ],
  //   );
  // }
}