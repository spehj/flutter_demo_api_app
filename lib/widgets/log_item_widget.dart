import 'package:flutter/material.dart';

class LogItemWidget extends StatelessWidget {
  /// Display log item as a ListTile
  /// Can add more data about each log
  final String logText;
  final String logHour;
  const LogItemWidget({Key? key, required this.logText, required this.logHour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(logHour), trailing: Text("ID: $logText"),);
  }
}
