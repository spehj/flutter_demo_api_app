import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {

  final String date;

  const DateWidget({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
        child: Center(child: Text(date, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)));
  }
}
