import 'package:flutter/material.dart';
import 'package:flutter_demo_api_app/services/logs_access_token.dart';
import 'package:flutter_demo_api_app/widgets/date_widet.dart';
import 'package:flutter_demo_api_app/widgets/log_item_widget.dart';
import 'package:intl/intl.dart';

import '../auth/secrets.dart';
import '../models/log.dart';
import '../services/logs_api.dart';
import 'logs_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Log> logs = [];
  @override
  void initState() {
    super.initState();
    // fetchLogs("2022-01-20T00:00:00Z", "2023-01-27T23:59:59Z");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Flutter Demo App")),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 4, right: 4, top: 12, bottom: 0),
        child:
        Column(
          children: [
              Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            DateWidget(date: "2.5."),
            DateWidget(date: "3.5."),
            DateWidget(date: "4.5."),
            DateWidget(date: "5.5."),
            DateWidget(date: "6.5."),
            DateWidget(date: "7.5."),
            DateWidget(date: "8.5."),

          ],
        ),
        SizedBox(height: 12,),
        Expanded(child: FutureBuilder(
          future: fetchLogs("2022-05-02T00:00:00Z", "2022-05-08T23:59:59Z"),
          builder: (BuildContext context, snapshot){
              switch (snapshot.connectionState){
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(),);
                case ConnectionState.done:
                default:
                  if (snapshot.hasError){
                    return Center(child: Text("Error: ${snapshot.error}"),);

                  }else if (snapshot.hasData){
                    List<Log> logs = snapshot.data as List<Log>;
                    Map<String, List<Log>> organizedLogs = {
                      '1': [], // Monday
                      '2': [], // Tuesday
                      '3': [], // Wednesday
                      '4': [], // Thursday
                      '5': [], // Friday
                      '6': [], // Saturday
                      '7': [], // Sunday
                    };
                    var dayIndex = 0; // 1 is Monday
                    for (var log in logs) {
                      String dayIndex = log.date.weekday.toString();
                      organizedLogs[dayIndex]?.add(log);
                    }

                    print("organized: $organizedLogs");
                    return LogsView(organizedLogs: organizedLogs);
                  }
                  else{
                    return CircularProgressIndicator();
                  }
              }
          },
        ),
        )],
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

  Future<List<Log>> fetchLogs(dateFrom, dateTo) async {
    final response = await LogsApi.fetchLogs(dateFrom, dateTo);
    print("RESPONSE: $response");
    // setState(() {
    //   logs = response;
    // });
    return Future.value(response);
  }


  // void fetchLogs(dateFrom, dateTo) async {
  //   final response = await LogsApi.fetchLogs(dateFrom, dateTo);
  //   print("RESPONSE: $response");
  //   setState(() {
  //     logs = response;
  //   });
  // }
}
