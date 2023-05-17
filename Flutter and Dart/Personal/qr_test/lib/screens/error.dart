import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  static const routeName = '/error';
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Error'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          '404 NOT FOUND',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ),
    );
  }
}
