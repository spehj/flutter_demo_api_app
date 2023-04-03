import 'package:flutter/material.dart';
import 'package:flutter_demo_api_app/services/logs_access_token.dart';
import 'package:flutter_demo_api_app/utils/weeks.dart';
import 'package:flutter_demo_api_app/widgets/date_widet.dart';
import 'package:flutter_demo_api_app/widgets/log_item_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../auth/secrets.dart';
import '../models/log.dart';
import '../providers/date_provider.dart';
import '../services/logs_api.dart';
import 'logs_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<Log> logs = [];
  int dayIndex = 0;
  bool isCurrent = false;
  final PageController _pageController = PageController(initialPage: 0);
  int currentWeekIndex = 1;
  late Weeks weeks = Weeks(year: _selectedValue);
  List<DateTime>? currentWeekList = [];
  static const List<int> yearsList = <int>[2020, 2021, 2022, 2023];
  int _selectedValue = yearsList.first;

  // _HomeScreenState(){
  //   _selectedValue = yearsList[0];
  //   weeks =
  // }

  @override
  void initState() {
    super.initState();
    // fetchLogs("2022-01-20T00:00:00Z", "2023-01-27T23:59:59Z");
    currentWeekList = weeks.weeks[currentWeekIndex];
  }

  @override
  Widget build(BuildContext context) {
    // print("WEEKS: ${weeks.weeks[currentWeekIndex]}");
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
                for (var i = 0; i < 7; i++)
                  GestureDetector(
                      onTap: () {
                        dayIndex = i;
                        print("Day index: $dayIndex}");
                        _pageController.animateToPage(
                          dayIndex,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        Provider.of<SelectedDateProvider>(context,
                                listen: false)
                            .updateSelectedDateProvider(dayIndex);
                      },
                      child: DateWidget(
                        date:
                            "${currentWeekList![i].toString().substring(5, 10).replaceRange(2, 3, ".")}",
                        widgetIndex: i,
                        currentDateIndex: dayIndex,
                      ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      // One week back
                      if (currentWeekIndex >= 2) {
                        setState(() {
                          currentWeekIndex -= 1;
                          currentWeekList = weeks.weeks[currentWeekIndex];
                          dayIndex = 0;
                          Provider.of<SelectedDateProvider>(context, listen: false)
                              .updateSelectedDateProvider(dayIndex);
                        });
                      }
                    },
                    child: Visibility(
                      visible: currentWeekIndex >=2,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    )),

                /// Choose year dropdown
                DropdownButton(
                    value: _selectedValue,
                    items: yearsList.map(
                    (e)=>DropdownMenuItem(value:e,child: Text(e.toString()),)

                ).toList(), onChanged: (value){
                      setState(() {
                        dayIndex = 0;
                        _selectedValue = value!;
                        weeks = Weeks(year: _selectedValue);
                        currentWeekList = weeks.weeks[currentWeekIndex];
                        Provider.of<SelectedDateProvider>(context, listen: false)
                            .updateSelectedDateProvider(dayIndex);
                      });
                }),
                GestureDetector(
                    onTap: () {
                      // One week forward
                      if (currentWeekIndex < weeks.weeks.length) {
                        setState(() {
                          currentWeekIndex += 1;
                          currentWeekList = weeks.weeks[currentWeekIndex];
                          dayIndex = 0;
                          Provider.of<SelectedDateProvider>(context, listen: false)
                              .updateSelectedDateProvider(dayIndex);
                        });
                      }
                    },
                    child: Visibility(
                      visible:  currentWeekIndex < weeks.weeks.length,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 30,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchLogs(currentWeekList!.first.toString(),
                    currentWeekList!.last.toString()),
                // fetchLogs("2022-05-02T00:00:00Z", "2022-05-08T23:59:59Z"),
                builder: (BuildContext context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
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
                        for (var log in logs) {
                          String dayIndex = log.date.weekday.toString();
                          organizedLogs[dayIndex]?.add(log);
                        }

                        // print("organized: $organizedLogs");
                        return LogsView(
                          organizedLogs: organizedLogs,
                          pageController: _pageController,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.black12,
        child: InkWell(
          onTap: () {
            print("Home Tapped");
            // Test
            // Weeks weeks = Weeks(year: 2022);
            // print("WEEKS: ${weeks.weeks.length}");
            setState(() {
              dayIndex = 0;
              _selectedValue = yearsList.first;
              weeks = Weeks(year: _selectedValue);
              currentWeekIndex = 1;
              currentWeekList = weeks.weeks[currentWeekIndex];
              Provider.of<SelectedDateProvider>(context, listen: false)
                  .updateSelectedDateProvider(dayIndex);
            });
          },
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
    dateTo = dateTo.replaceRange(11, 23, "23:59:59Z");
    final response = await LogsApi.fetchLogs(dateFrom, dateTo);
    return Future.value(response);
  }
}
