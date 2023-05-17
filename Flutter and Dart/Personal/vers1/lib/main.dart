import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Screens/loginScreen.dart';
import 'provider/login_provider.dart';
import 'Screens/LandingScreen.dart';
import 'Screens/DashboardScreen.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://yzifoygpezdqzuywwkob.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl6aWZveWdwZXpkcXp1eXd3a29iIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODEyMTY4MDYsImV4cCI6MTk5Njc5MjgwNn0.kMp6cK2zSpaFXnpzD2lb10Bd3XhrpQcpLtOWqZG4xCw',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        theme: ThemeData(
            useMaterial3: true,
            textTheme: const TextTheme(
              labelMedium: TextStyle(
                fontSize: 40,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.normal,
              ),
              displaySmall: TextStyle(
                fontSize: 16,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w300,
              ),
              bodyMedium: TextStyle(
                fontSize: 16,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.normal,
              ),
              headlineSmall: TextStyle(
                fontSize: 19,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.normal,
              ),
            ),
            colorScheme: const ColorScheme.dark(
                primary: Color(0xFF9AFEF0),
                // secondary: ,
                onPrimary: Colors.white70,
                // onSecondary: ,
                // onError: ,
                primaryVariant: Color(0xFFDBFBFC),
                secondaryVariant: Color(0xFF6CAEC0))),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          LandingScreen.routeName: (context) => LandingScreen(),
          DashboardScreen.routeName: (context) => DashboardScreen(),
        },
        initialRoute: LoginScreen.routeName,
      ),
    );
  }
}
