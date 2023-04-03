import 'package:flutter/material.dart';

class DateWidget extends StatefulWidget {

  final String date;
  final bool isSelected;

  const DateWidget({Key? key, required this.date, required this.isSelected}) : super(key: key);

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: widget.isSelected? Colors.black38 : Colors.blue, borderRadius: BorderRadius.circular(12)),
        child: Center(child: Text(widget.date, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)));
  }
}
