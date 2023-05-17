import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'widget/fetch.dart';
import '../Screens/location_page.dart';
import '../Screens/login.dart';
import '../Screens/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            backgroundColor: Color(0xFFDDDDDD),
            secondaryHeaderColor: Colors.black,
            primaryColor: Color(0xFFEEEEEE),
            accentColor: Color(0xFF38ac65)),
        initialRoute: Splash.routeName,
        routes: {
          Splash.routeName: (context) => Splash(),
          Login.routeName: (context) => Login(),
          LocationPage.routeName: (context) => LocationPage(),
          Fetch.routeName: (context) => Fetch(),
        });
  }
}
