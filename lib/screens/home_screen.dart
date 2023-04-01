import 'package:flutter/material.dart';
import 'package:flutter_demo_api_app/widgets/date_widet.dart';
import 'package:flutter_demo_api_app/widgets/log_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Flutter Demo App")),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 4, right: 4, top: 12, bottom: 0),
        child: Column(
          children: [
          Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DateWidget(date: "1.1."),
            DateWidget(date: "2.1."),
            DateWidget(date: "3.1."),
            DateWidget(date: "4.1."),
            DateWidget(date: "5.1."),
            DateWidget(date: "6.1."),
            DateWidget(date: "7.1."),

          ],
        ),
        SizedBox(height: 12,),
        Expanded(child: ListView(
            children: ListTile.divideTiles(context: context, tiles: [
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
              LogItemWidget(logText: "Log 1", logHour: "10:00"),
            ],
            ).toList(),)),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.black12,
        child: InkWell(
          onTap: () => print("Home Tapped"),
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Column(
              children: const [
                Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                Text("Home")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
