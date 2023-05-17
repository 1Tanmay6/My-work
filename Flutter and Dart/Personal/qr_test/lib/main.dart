import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_test/providers/qr_code.dart';

import './screens/scanner_screen.dart';
import './screens/details.dart';
import './screens/error.dart';
import './models/ticket.dart';
import './providers/tickets.dart';
import './screens/all_tickets_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Tickets(),
        ),
        ChangeNotifierProvider(
          create: (context) => QrCode(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xFFeb0028),
            focusColor: Colors.black,
            hintColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.black,
              foregroundColor: Color(0xFFeb0028),
            )),
        title: 'Ticket Scanner',
        home: ScannerScreen(),
        routes: {
          ScannerScreen.routeName: (ctx) => ScannerScreen(),
          Details.routeName: (ctx) => Details(),
          AllTicketsScreen.routeName: (ctx) => AllTicketsScreen(),
          ErrorScreen.routeName: (ctx) => ErrorScreen(),
        },
      ),
    );
  }
}
