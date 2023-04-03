import 'package:flutter/material.dart';
import 'package:flutter_demo_api_app/utils/weeks.dart';
import 'package:flutter_demo_api_app/widgets/date_widet.dart';
import 'package:provider/provider.dart';

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
  // List of logs to display for one week
  List<Log> logs = [];
  int dayIndex = 0;

  // Page controller for PageView
  final PageController _pageController = PageController(initialPage: 0);

  // List of years for drowpdown menu
  static const List<int> yearsList = <int>[2020, 2021, 2022, 2023];

  // Get initial selected value for dropdown list
  int _selectedValue = yearsList.first;

  // Current week index start with 1, because of map with 1 as the week 1
  int currentWeekIndex = 1;

  // Get all weeks for this year
  late Weeks weeks = Weeks(year: _selectedValue);

  // List to store this week dates
  List<DateTime>? currentWeekList = [];

  @override
  void initState() {
    super.initState();
    // Initialize list of dates for this week
    currentWeekList = weeks.weeks[currentWeekIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Flutter Demo App")),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 4, right: 4, top: 12, bottom: 0),
        child: Column(
          children: [
            /// ROW WITH DATES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Create 7 dates
                for (var i = 0; i < 7; i++)
                  GestureDetector(
                      onTap: () {
                        dayIndex = i;
                        _pageController.animateToPage(
                          dayIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        Provider.of<SelectedDateProvider>(context,
                                listen: false)
                            .updateSelectedDateProvider(dayIndex);
                      },
                      child: DateWidget(
                        date: currentWeekList![i]
                            .toString()
                            .substring(5, 10)
                            .replaceRange(2, 3, "."),
                        widgetIndex: i,
                        currentDateIndex: dayIndex,
                      )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            /// CONTRLS FOR MOVING BETWEEN WEEKS/YEARS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Move one week backwards
                GestureDetector(
                    onTap: () {
                      // One week back
                      if (currentWeekIndex >= 2) {
                        setState(() {
                          currentWeekIndex -= 1;
                          currentWeekList = weeks.weeks[currentWeekIndex];
                          dayIndex = 0;
                          Provider.of<SelectedDateProvider>(context,
                                  listen: false)
                              .updateSelectedDateProvider(dayIndex);
                        });
                      }
                    },
                    child: Visibility(
                      visible: currentWeekIndex >= 2,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    )),

                // Choose year dropdown
                DropdownButton(
                    value: _selectedValue,
                    items: yearsList
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        dayIndex = 0;
                        _selectedValue = value!;
                        weeks = Weeks(year: _selectedValue);
                        currentWeekList = weeks.weeks[currentWeekIndex];
                        Provider.of<SelectedDateProvider>(context,
                                listen: false)
                            .updateSelectedDateProvider(dayIndex);
                      });
                    }),
                // Move one week forwards
                GestureDetector(
                    onTap: () {
                      // One week forward
                      if (currentWeekIndex < weeks.weeks.length) {
                        setState(() {
                          currentWeekIndex += 1;
                          currentWeekList = weeks.weeks[currentWeekIndex];
                          dayIndex = 0;
                          Provider.of<SelectedDateProvider>(context,
                                  listen: false)
                              .updateSelectedDateProvider(dayIndex);
                        });
                      }
                    },
                    child: Visibility(
                      visible: currentWeekIndex < weeks.weeks.length,
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 30,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 12,
            ),

            /// LIST OF LOGS
            Expanded(
              child: FutureBuilder(
                future: fetchLogs(currentWeekList!.first.toString(),
                    currentWeekList!.last.toString()),
                builder: (BuildContext context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
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
                        // Add Log to it's day in week
                        for (var log in logs) {
                          String dayIndex = log.date.weekday.toString();
                          organizedLogs[dayIndex]?.add(log);
                        }
                        // Display logs in PageView
                        return LogsView(
                          organizedLogs: organizedLogs,
                          pageController: _pageController,
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                  }
                },
              ),
            )
          ],
        ),
      ),

      /// HOME BUTTON
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.black12,
        child: InkWell(
          onTap: () {
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
            padding: const EdgeInsets.only(top: 8.0),
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
    /// Fetch LOGS from server
    dateTo = dateTo.replaceRange(11, 23, "23:59:59Z");
    final response = await LogsApi.fetchLogs(dateFrom, dateTo);
    return Future.value(response);
  }
}
