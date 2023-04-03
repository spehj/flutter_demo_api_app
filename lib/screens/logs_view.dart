import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/log.dart';
import '../widgets/log_item_widget.dart';

class LogsView extends StatefulWidget {
  final Map<String, List<Log>> organizedLogs;
  final PageController pageController;
  final Function(int) newDayIndex;

  const LogsView({super.key, required this.organizedLogs, required this.pageController, required this.newDayIndex});

  @override
  State<LogsView> createState() => _LogsViewState();
}

class _LogsViewState extends State<LogsView> {
  final List<int> _days = [1, 2, 3, 4, 5, 6, 7];
  // late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _pageController = PageController(initialPage: 0);
  }

  // void onPageChanged(int index){
  //   // setState(() {
  //   //
  //   // });
  //   widget.newDayIndex(index);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        // onPageChanged: onPageChanged,
        controller: widget.pageController,// _pageController,
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
}