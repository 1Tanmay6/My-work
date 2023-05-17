import 'package:crudsupa/demo_todo.dart';
import 'package:crudsupa/demo_todo2.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'signup.dart';
import 'landing_page.dart';

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
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.lightBlue,
              backgroundColor: Colors.grey[50]),
          useMaterial3: true,
        ),
        routes: {
          TodoScreen2.routeName: (context) => TodoScreen2(),
          TodoScreen.routeName: (context) => TodoScreen(),
          Login.routeName: (context) => Login(),
          LandingPage.routeName: (context) => LandingPage(),
          SignUp.routeName: (context) => SignUp(),
        },
        // home: Login(),

        initialRoute: Login.routeName,
      ),
    );
  }
}

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl6aWZveWdwZXpkcXp1eXd3a29iIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODEyMTY4MDYsImV4cCI6MTk5Njc5MjgwNn0.kMp6cK2zSpaFXnpzD2lb10Bd3XhrpQcpLtOWqZG4xCw