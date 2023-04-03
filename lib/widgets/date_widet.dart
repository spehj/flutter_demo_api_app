import 'package:flutter/material.dart';
import 'package:flutter_demo_api_app/providers/date_provider.dart';
import 'package:provider/provider.dart';

class DateWidget extends StatefulWidget {
  final String date;
  final int widgetIndex;
  final int currentDateIndex;

  const DateWidget({
    Key? key,
    required this.date,
    required this.widgetIndex,
    required this.currentDateIndex,
  }) : super(key: key);

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  late int? currentDateIndex;

  @override
  void initState() {
    super.initState();
    currentDateIndex =
        Provider.of<SelectedDateProvider>(context, listen: false)
            .selectedDateIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedDateProvider>(
      builder: (context, selectedDateProvider, child) {

        currentDateIndex = selectedDateProvider.index;
        currentDateIndex ??= 0;

        return Container(
          height: 50,
          width: 50,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: currentDateIndex == widget.widgetIndex
                ? Colors.black38
                : Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              widget.date,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
