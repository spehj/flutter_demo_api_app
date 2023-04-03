import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/log.dart';
import '../providers/date_provider.dart';
import '../widgets/log_item_widget.dart';

class LogsView extends StatefulWidget {
  final Map<String, List<Log>> organizedLogs;
  final PageController pageController;


  const LogsView({super.key, required this.organizedLogs, required this.pageController});

  @override
  State<LogsView> createState() => _LogsViewState();
}

class _LogsViewState extends State<LogsView> {
  final List<int> _days = [1, 2, 3, 4, 5, 6, 7];

  void onPageChanged(int index){
    Provider.of<SelectedDateProvider>(context, listen: false).updateSelectedDateProvider(index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        onPageChanged: onPageChanged,
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