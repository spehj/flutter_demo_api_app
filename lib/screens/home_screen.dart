import 'package:flutter/material.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 50,
                    child: Center(child: Text("1.1."))),
                Container(
                    height: 50,
                    child: Center(child: Text("2.1."))),
                Container(
                    height: 50,
                    child: Center(child: Text("3.1."))),
                Container(
                    height: 50,
                    child: Center(child: Text("4.1."))),
                Container(
                    height: 50,
                    child: Center(child: Text("5.1."))),
              ],
            ),
            Expanded(child: ListView(
              children: [
                Text("Log 1"),
                Text("Log 2"),
                Text("Log 3"),
                Text("Log 4"),

              ],
            ))
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
