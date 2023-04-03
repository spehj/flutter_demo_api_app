import 'package:flutter/material.dart';
import 'package:flutter_demo_api_app/providers/date_provider.dart';
import 'package:flutter_demo_api_app/screens/home_screen.dart';
import 'package:flutter_demo_api_app/services/logs_access_token.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

// Future<void> main() async {
//   await dotenv.load();
//   await initAccessToken();
//   runApp(
//     MultiProvider(
//         providers: [Provider(create: (_) => SelectedDateProvider())],
//         child: const MyApp()),
//   );
// }

Future<void> main() async {
  await dotenv.load();
  await initAccessToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectedDateProvider>(
      create: (_)=>SelectedDateProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter API Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.epilogueTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: Colors.white,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
