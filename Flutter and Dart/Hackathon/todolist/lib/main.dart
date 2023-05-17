import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/services/auth_service.dart';

import './providers/app.dart';
import './screens/Signup_screen.dart';
import './screens/login_screen.dart';

void main() {
  runApp(Core());
}

class Core extends StatelessWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
        routes: {
          SignUpScreen.routeName: (context) => SignUpScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
        },
        initialRoute: LoginScreen.routeName,
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
